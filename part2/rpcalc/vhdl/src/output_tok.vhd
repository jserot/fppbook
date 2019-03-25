library ieee;
use ieee.std_logic_1164.all;
use work.token.all;

entity output_tok is
  port(e_rdy: in std_logic;
       tok_i: in token_t;
       r_rdy: out std_logic
       );
end entity;

architecture beh of output_tok is
begin
  process
    variable t: token_t;
  begin
    r_rdy <= '1';
    wait until e_rdy = '1'; -- Wait for input
    t := tok_i;
    assert false report "output_tok:got " & to_string(t) severity note;
    r_rdy <= '0'; 
    wait until e_rdy = '0'; -- Wait for acknowledge
    r_rdy <= '1';
  end process;
end architecture;
