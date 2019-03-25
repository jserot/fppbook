library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TX is
  generic(D: natural);
  port( clk: in std_logic;
        txData: in std_logic_vector(7 downto 0);
        txWr: in std_logic;
        txRdy: out std_logic;
        tx: out std_logic;
        rst: in std_logic
        );
end entity;

architecture struct of TX is
  signal Lr, LSr, Lk, LIk, Li, LIi, kd, i11, r0: std_logic;
begin
  po: entity work.tx_po
      generic map(D)
      port map(clk, txData, Lr, LSr, Li, LIi, Lk, LIk, kd, i11, r0);
  pc: entity work.tx_pc
      port map(clk, rst, txWr, txRdy, tx, Lr, LSr, Li, LIi, Lk, LIk, kd, i11, r0);
end architecture;
