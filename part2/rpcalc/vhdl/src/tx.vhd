-- Emulates the TX side of an UART connected to the host PC

library ieee ;
use ieee.std_logic_1164.all;

entity tx is
  port (tx_wr: in std_logic; 
        tx_data: in character;
        tx_rdy: out std_logic
        );
end entity;

architecture beh of tx is
begin
  process
    variable c: character;
  begin
    tx_rdy <= '1';
    wait until tx_wr = '1';
    c := tx_data;
    if c = CR then c := '^'; end if; -- for printing
    assert false report "uart.tx:got " & c severity note;
    tx_rdy <= '0'; 
    wait until tx_wr = '0';
  end process;
end architecture;
