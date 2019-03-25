library ieee;
use ieee.std_logic_1164.all;

entity RX is
  generic(D: natural);
  port(
        clk: in std_logic;
        rx: in std_logic;
        rxData: out std_logic_vector(7 downto 0);
        rxRdy: out std_logic;
        rxErr: out std_logic;
        rst: in std_logic
        );
end entity;

architecture struct of RX is
  signal Lr, LSr, Lk, LIk, selk, Li, LIi, Ld, kd, i10: std_logic;
begin
  po: entity work.rx_po
      generic map(D)
      port map(clk, rx, rxData, rxErr, Lr, LSr, Li, LIi, Lk, LIk, selk, Ld, kd, i10);
  pc: entity work.rx_pc
      port map(clk, rst, rx, rxRdy, Lr, LSr, Li, LIi, Lk, LIk, selk, Ld, kd, i10);
end architecture;
