library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.img_types.all;

package msfl_types is
  type pixel8_bundle is array(natural range <>, natural range <>) of pixel8;
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.img_types.all;
use work.msfl_types.all;

entity msfl is
  generic (
    width: positive := 3;
    height: positive := 3;
    im_width: positive := 128;
    im_height: positive := 128
    );
  port (
    clk: in std_logic;
    rst: in std_logic;
    data_i: in pixel8;
    fval_i: in std_logic;
    dval_i: in std_logic;
    data_o: out pixel8_bundle(0 to height-1, 0 to width-1);
    fval_o: out std_logic;
    dval_o: out std_logic
    );
end entity;

architecture rtl of msfl is

  constant buffer_depth: positive := (height-1)*im_width + width;
  type fifo_t is array (0 to buffer_depth-1) of pixel8;
  signal z: fifo_t;

begin

  BUF_DATA: process(rst, clk)
  begin
    if rst = '0' then
      z <= (others => (others => '0'));
    elsif rising_edge(clk) then
      if fval_i = '1' and dval_i = '1' then
        for i in 1 to buffer_depth-1 loop
          z(i) <= z(i-1);
        end loop;			
        z(0) <= data_i;	    
      end if;
    end if;
	end process;
	
    BUF_CTL: process(rst, clk)
    begin
    if rst = '0' then
      fval_o <= '0';
      dval_o <= '0';
    elsif rising_edge(clk) then			
      fval_o <= fval_i;
      dval_o <= dval_i;
    end if;
    end process;
	
    R: for i in 0 to height-1 generate
      C: for j in 0 to width-1 generate
        data_o(i,j) <= z(i*im_width+j);
      end generate;
    end generate;

end rtl;
