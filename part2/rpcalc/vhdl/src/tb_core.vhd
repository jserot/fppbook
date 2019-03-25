library ieee;
use ieee.std_logic_1164.all;	   
use ieee.numeric_std.all;
use work.token.all;

entity tb_core is
end tb_core;

architecture struct of tb_core is

  signal tok_in, tok_out: token_t;
  signal lst_x: num_t;
  signal e_rdy1, r_rdy1: std_logic;
  signal e_rdy2, r_rdy2: std_logic;
  signal rst, clk: std_logic;

  -- constant test_1: token_stream := (
  --   (Number, mk_num(12)), (Enter, 0), (Number, mk_num(34)), (Plus, 0), (Number, mk_num(2)), (Times, 0));
  --    -- "12 ^ 34 + 2 * => -- 46 92"
  -- constant test_2: token_stream := (
  --   (Number, mk_num(12)), (Enter, 0), (Number, mk_num(34)), (Enter, 0), (Number, mk_num(2)), (Times, 0), (Plus, 0));
  --    -- "12 ^ 34 ^ 2 * + => 68 80"

  constant test_3: token_stream := (
    mk_tok(2), mk_tok(Enter), mk_tok(10), mk_tok(Times),
    mk_tok(5), mk_tok(Enter), mk_tok(1), mk_tok(Minus), mk_tok(Plus));
    -- "2 ^ 10 * 5 ^ 1 - + => 20 24 
begin

  I: entity work.input_tok generic map (test_3) port map(r_rdy1, tok_in, e_rdy1);
  C: entity work.calc_core generic map (trace=>false) port map(clk, rst, e_rdy1, tok_in, r_rdy1, r_rdy2, tok_out, e_rdy2, lst_x);
  O: entity work.output_tok port map(e_rdy2, tok_out, r_rdy2);

  CLOCK: process
  begin
    clk<='1'; wait for 5 ns;
    clk<='0'; wait for 5 ns;
  end process;

  RESET: process
  begin
    rst <= '0'; wait for 5 ns;
    rst <= '1'; wait;
  end process;

end architecture;
