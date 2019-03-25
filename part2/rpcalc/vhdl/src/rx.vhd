-- Emulates the RX side of an UART connected to the host PC

library ieee ;
use ieee.std_logic_1164.all;

entity rx is
  generic (input_stream: string);
  port (rx_rd: in std_logic;
        rx_data: out character;
        rx_rdy: out std_logic 
    );
end entity;

architecture beh of rx is
begin
  process
    variable c: character;
  begin
    for i in input_stream'range loop
      c := input_stream(i);
      if c = '^' then c := CR; end if;
      rx_data <= c;
      rx_rdy <= '1';
      assert false report "rx: wrote " & c severity note;
      wait until rx_rd = '1'; 
      wait until rx_rd = '0';
    end loop;
    rx_rdy <= '1';
    wait; -- That's all folks
  end process;
end architecture;
