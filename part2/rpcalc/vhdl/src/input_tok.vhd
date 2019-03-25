library ieee;
use ieee.std_logic_1164.all;
use work.token.all;

entity input_tok is
  generic (input_stream: token_stream);
  port(r_rdy: in std_logic;
       tok_i: out token_t;
       e_rdy: out std_logic
       );
end entity;

architecture beh of input_tok is
begin
  process
    variable t: token_t;
  begin
    e_rdy <= '0';
    for i in input_stream'range loop
      wait until r_rdy = '1';
      t := input_stream(i);
      tok_i <= t;  
      e_rdy <= '1';
      assert false report "input_tok: wrote token  " & to_string(t) severity note;
      wait until r_rdy = '0'; -- wait for acknowledge
      e_rdy <= '0';
    end loop;
    wait; -- stop
  end process;
end architecture;
