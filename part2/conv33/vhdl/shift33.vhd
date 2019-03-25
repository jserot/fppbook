library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.img_types.all;

entity shift33 is
  generic (
    im_width: positive := 128;
    im_height: positive := 128;
    hblank: positive := 2
    );
  port (
    clk: in  std_logic;
    rst: in  std_logic;
    data_i: in pixel8;
    fval_i: in std_logic;
    dval_i: in std_logic;
    data_o: out pixel8;
    fval_o: out std_logic;
    dval_o: out std_logic
    );
end entity;

architecture rtl of shift33 is
  constant delay: positive := im_width + hblank + 1;
  type reg_t is array (0 to delay-1) of std_logic_vector(0 to 1);  -- 0:fval, 1:dval
  signal v: reg_t;
  signal enable: boolean;
begin
  GEN_CTL: process (rst, clk)
  begin
    if rst='0' then
      v <= (others => (others => '0'));
    elsif rising_edge(clk) then
      for i in 1 to delay-1 loop
        v(i) <= v(i-1);
      end loop;			
      v(0)(0) <= fval_i;	    
      v(0)(1) <= dval_i;	    
    end if;
  end process;

  fval_o <= v(delay-1)(0);
  dval_o <= v(delay-1)(1);

  GEN_DATA: process (rst, clk)
    variable y: integer range 0 to im_height;
    variable x: integer range 0 to im_width;
  begin
    if rst='0' then
      x := 0;
      y := 0;
    elsif rising_edge(clk) then
      if fval_i='1' and dval_i='1' then
        x := x+1;
        if x = im_width then
          x := 0;
          y := y+1;
        end if;
        enable <= y>1 and x>1;
      end if;
    end if;
  end process;

  data_o <= data_i when enable else to_unsigned(0,8);

end architecture;
