library ieee;
use ieee.std_logic_1164.all;	   
use ieee.numeric_std.all;

entity tb is
end tb;

architecture struct of tb is

signal H: std_logic;
signal dout: integer;
signal rst: std_logic;

begin

  CLOCK: process
    begin
      H <= '0'; wait for  5 ns;
      H <= '1'; wait for  5 ns;
    end process;

  RESET: process
  begin
    rst <= '1'; wait for 1 ns;
    rst <= '0'; wait;
  end process;

  U_Top: entity work.top port map(H,dout,rst);

end architecture;
