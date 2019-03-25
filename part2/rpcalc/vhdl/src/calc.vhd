library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.token.all;

entity calc is
  generic (trace: boolean := false);
  port(
    clk: in std_logic;
    rst: in std_logic;
	tx_wr: out std_logic;
	tx_data: out character;
	rx_rd: out std_logic;
	rx_data: in character;
	tx_rdy: in std_logic;
	rx_rdy: in std_logic;
    last_x: out num_t; -- for debug
    last_tag: out tag_t -- for debug
    );
end entity;

architecture rtl of calc is

  signal tok1, tok2: token_t;
  signal r_rdy1, e_rdy1: std_logic;
  signal r_rdy2, e_rdy2: std_logic;

begin
  last_tag <= tok1.tag; -- for debug
  R: entity work.c2t port map(clk, rst, rx_rd, rx_data, rx_rdy, r_rdy1, tok1, e_rdy1);
  C: entity work.calc_core generic map (trace) port map(clk, rst, e_rdy1, tok1, r_rdy1, r_rdy2, tok2, e_rdy2, last_x);
  T: entity work.t2c generic map (num_size, 3) port map(clk, rst, e_rdy2, tok2, r_rdy2, tx_wr, tx_data, tx_rdy);
end architecture;
