-- Emulates an UART connected to the host PC

library ieee ;
use ieee.std_logic_1164.all;

entity uart is
  generic (input_stream: string);
  port (tx_wr: in std_logic; 
        tx_data: in character;
        rx_rd: in std_logic;
        rx_data: out character;
        tx_rdy: out std_logic; 
        rx_rdy: out std_logic 
    );
end entity;

architecture struct of uart is
begin
  R: entity work.rx generic map(input_stream) port map(rx_rd, rx_data, rx_rdy);
  T: entity work.tx port map(tx_wr, tx_data, tx_rdy);
end architecture;
