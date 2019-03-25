library ieee ;
use ieee.std_logic_1164.all;
use work.token.all;

entity top is
  port (
	CLOCK_50: in std_logic;
    BUT0: in std_logic;
    SSD5: out std_logic_vector(7 downto 0);
    SSD3: out std_logic_vector(7 downto 0);
    SSD2: out std_logic_vector(7 downto 0);
    SSD1: out std_logic_vector(7 downto 0);
    SSD0: out std_logic_vector(7 downto 0)
    );
end entity;

architecture struct of top is

  signal clock, reset, int_rst: std_logic;
  signal rx_rdy, tx_rdy: std_logic;
  signal tx_wr, rx_rd: std_logic;
  signal rx_data, tx_data: character;
  signal last_x: num_t;  -- for debug
  signal last_tag: tag_t;  -- for debug

begin
  reset <= int_rst and BUT0;
  uart: entity work.vj_uart port map(CLOCK_50, clock, int_rst, tx_wr, tx_data, rx_rd, rx_data, tx_rdy, rx_rdy);
  app: entity work.calc port map(clock, reset, tx_wr, tx_data, rx_rd, rx_data, tx_rdy, rx_rdy, last_x, last_tag);
  disp: entity work.display port map(last_x, last_tag, SSD5, SSD3, SSD2, SSD1, SSD0);
end architecture;
