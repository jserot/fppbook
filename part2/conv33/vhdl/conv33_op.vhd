library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package conv33_types is
  type t_coeffs is array(0 to 2, 0 to 2) of unsigned(7 downto 0);
end package conv33_types;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.img_types.all;
use work.msfl_types.all;
use work.conv33_types.all;

-- DATA_i and COEFFS :
--
-- +-----+-----+-----+
-- + 2,2 + 2,1 | 2,0 |
-- +-----+-----+-----+
-- + 1,2 + 1,1 | 1,0 |
-- +-----+-----+-----+
-- + 0,2 + 0,1 | 0,0 |
-- +-----+-----+-----+
--

entity conv33_op is
  generic (
    coeffs: t_coeffs;
    normf: integer  := 1
    );
  port (
    clk: in  std_logic;
    rst: in  std_logic;
    data_i: in pixel8_bundle(0 to 2, 0 to 2);
    fval_i: in std_logic;
    dval_i: in std_logic;
    data_o: out pixel8;
    fval_o: out std_logic;
    dval_o: out std_logic
    );
end entity;

architecture rtl of conv33_op is
begin
    process(rst, clk)
      variable acc: unsigned(15 downto 0);
    begin
      if rst = '0' then
        fval_o <= '0';
         dval_o <= '0';
      elsif rising_edge(clk) then			
        dval_o <= dval_i;
        fval_o <= fval_i;
        if fval_i = '1' and dval_i = '1' then
          acc := to_unsigned(0, 16);
          for i in 0 to 2 loop
            for j in 0 to 2 loop
              acc := acc + data_i(i,j) * coeffs(i,j);
            end loop;
          end loop;
          data_o <= resize(acc/normf, 8);
        end if;
      end if;
    end process;
end;
