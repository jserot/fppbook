library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity output is
  port(rx_rdy: in std_logic;
       rx_data: in std_logic_vector(7 downto 0);
       rx_err: in std_logic
       );
end entity;

architecture beh of output is
begin
  process
    variable d: integer;
    variable e: boolean;
  begin
    wait until rx_rdy='0'; -- start of reception
    wait until rx_rdy='1'; -- end of reception
    d := to_integer(unsigned(rx_data));
    e := rx_err='1';
    assert false report "output:got '" & integer'image(d) & "' (e=" & boolean'image(e) & ")" severity note;
  end process;
end architecture;
