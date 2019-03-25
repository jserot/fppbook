library ieee;
use ieee.std_logic_1164.all;	   
use work.data_types.all;	   

entity tb is
end tb;

architecture struct of tb is

  signal clk: std_logic;
  signal rst: std_logic;
  signal TxWr: std_logic;
  signal TxData: std_logic_vector(7 downto 0);
  signal RxErr: std_logic;
  signal RxRdy: std_logic;
  signal RxData: std_logic_vector(7 downto 0);
  signal TxRdy: std_logic;
  signal RxTx: std_logic;

  constant test_data: int8_array := ( 170, 171, 69 );

begin
  I: entity work.input generic map(test_data, 95 ns) port map(TxWr, TxData, TxRdy);
  U: entity work.uart
    generic map(4)
    port map(clk, rst, TxWr, TxData, TxRdy, RxTx, RxRdy, RxData, RxErr, RxTx);
  O: entity work.output port map(RxRdy, RxData, RxErr);

  CLOCK: process
  begin
    clk<='1'; wait for 5 ns;
    clk<='0'; wait for 5 ns;
  end process;

  RESET: process
  begin
    rst <= '1'; wait for 5 ns;
    rst <= '0'; wait;
  end process;
end architecture;
