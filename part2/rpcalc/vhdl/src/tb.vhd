library ieee;
use ieee.std_logic_1164.all;	   
use ieee.numeric_std.all;
use work.token.all;

entity tb is
end tb;

architecture struct of tb is

  signal rst, clk: std_logic;
  signal rx_rdy, tx_rdy: std_logic;
  signal tx_wr, rx_rd: std_logic;
  signal rx_data, tx_data: character;

  constant test_1: string := "12^34+2*"; -- => 46 92
  constant test_2: string := "12^34^2*+"; -- => 68 80
  constant test_3: string := "2^10*5^1-+"; -- => 20 4 24 
  constant test_4: string := "2^2-"; -- => 0
  constant test_5: string := "12^2/"; -- => 6

begin

  uart: entity work.uart
    generic map(test_3)
    port map(tx_wr, tx_data, rx_rd, rx_data, tx_rdy, rx_rdy);
  calc: entity work.calc
    generic map(false)
    port map(clk, rst, tx_wr, tx_data, rx_rd, rx_data, tx_rdy, rx_rdy, open, open);
  CLOCK: process
  begin
    clk<='1'; wait for 5 ns;
    clk<='0'; wait for 5 ns;
  end process;

  RESET: process
  begin
    rst <= '0'; wait for 1 ns;
    rst <= '1'; wait;
  end process;

end architecture;
