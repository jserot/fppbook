library ieee;
use ieee.std_logic_1164.all;

entity reg is
  generic (width: integer);
  port ( clk: in std_logic;
         ena: in std_logic;
         din: in std_logic_vector(width-1 downto 0);
         dout: out std_logic_vector(width-1 downto 0));
end entity;

architecture rtl of reg is
begin
  process(clk)
    begin
      if rising_edge(clk) then
        if ( ena = '1' ) then
          dout <= din;
        end if;
      end if;
    end process;
end architecture;
