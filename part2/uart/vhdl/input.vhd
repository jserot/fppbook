library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.data_types.all;

entity input is
  generic (input_data: int8_array;
           tempo: time);
  port(tx_wr: out std_logic;
       tx_data: out std_logic_vector(7 downto 0);
       tx_rdy: in std_logic
       );
end entity;

architecture beh of input is
begin
  process
    variable d: integer;
  begin
    tx_wr <= '0';
    for i in input_data'range loop
      wait for tempo;
      d := input_data(i);
      tx_data <= std_logic_vector(to_unsigned(d, 8));
      tx_wr <= '1';
      assert false report "input: wrote '" & integer'image(d) & "'" severity note;
      wait for 20 ns;
      tx_wr <= '0';
      wait until tx_rdy = '1';
    end loop;
    wait;
  end process;
end architecture;
