--   vjuart.vhd - Virtual JTAG + UART I/F encapsulation
--
--   Translated from Verilog by JS, 2018-12-09
--
--   Copyright (C) 2014  Binary Logic (nhi.phan.logic at gmail.com).
--   Copyright (C) 2018  J. Serot Logic (jocelyn dot serot at uca.fr).
--
--   This file is part of the Virtual JTAG UART toolkit
--   
--   Virtual UART is free software: you can redistribute it and/or modify
--   it under the terms of the GNU General Public License as published by
--   the Free Software Foundation, either version 3 of the License, or
--   (at your option) any later version.
--   
--   This program is distributed in the hope that it will be useful,
--   but WITHOUT ANY WARRANTY; without even the implied warranty of
--   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--   GNU General Public License for more details.
--   
--   You should have received a copy of the GNU General Public License
--   along with this program.  If not, see <http://www.gnu.org/licenses/>.

library ieee ;
use ieee.std_logic_1164.all;

entity vj_uart is
  port (
	clk_i: in std_logic;
	clk_o: out std_logic;
	rst_o: out std_logic;
	tx_wr: in std_logic; 
	tx_data: in character;
	rx_rd: in std_logic;
	rx_data: out character;
	tx_rdy: out std_logic; -- ! TX  full
	rx_rdy: out std_logic -- ! RX empty
    );
end entity;

architecture struct of vj_uart is

  signal clk, rst: std_logic;
  signal areset, locked: std_logic; -- not used
  signal txmt, rxfl: std_logic; -- not used
  signal txfl, rxmt: std_logic;

  component pll_clock is
    port(
      areset: in std_logic;
      inclk0: in std_logic;
      c0: out std_logic;
      locked: out std_logic);
  end component;

  component reset is
    port(
      clk_i: in std_logic;
      nreset_o: out std_logic);
  end component;

  component jtag_uart is
    port(
	clk_i: in std_logic;
	nreset_i: in std_logic;
	wr_i: in std_logic;
	data_i: in character;
	rd_i: in std_logic;
	data_o: out character;
	txmt: out std_logic;
	txfl: out std_logic;
	rxmt: out std_logic;
	rxfl: out std_logic);
  end component;

begin
  clock: pll_clock port map(areset, clk_i, clk, locked);
  rset: reset port map(clk, rst);
  uart: jtag_uart port map(clk, rst, tx_wr, tx_data, rx_rd, rx_data, txmt, txfl, rxmt, rxfl);
  clk_o <= clk;
  rst_o <= rst;
  tx_rdy <= not rxfl;
  rx_rdy <= not rxmt;
end architecture;
