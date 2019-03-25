library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
library msi;
use msi.components.all;

entity tx_po is
  generic(D: natural);
  port (-- E/S
        clk: in std_logic;
        txData: in std_logic_vector(7 downto 0);
        -- Interface avec la PC
        Lr: in std_logic;
        LSr: in std_logic;
        Li: in std_logic;
        LIi: in std_logic;
        Lk: in std_logic;
        LIk: in std_logic;
        kd: out std_logic;
        i11: out std_logic;
        r0: out std_logic);
end entity;

architecture arch of tx_po is

  function Parite(x: std_logic_vector(7 downto 0)) return std_logic is
  begin
    return x(7) xor x(6) xor x(5) xor x(4)
       xor x(3) xor x(2) xor x(1) xor x(0);
  end Parite;

  constant KW: natural := integer(ceil(log2(real(D))+0.5));

  signal r: std_logic_vector(10 downto 0);
  signal r_in: std_logic_vector(10 downto 0);
  signal i: unsigned(3 downto 0);
  signal k: unsigned(KW-1 downto 0);

begin
  r_in <= '1' & Parite(txData) & txData & '0';
  r0 <= r(0);
  Rr: entity msi.shift_reg
      generic map(11) port map(clk, Lr, LSr, '1', r_in, '1', r);
  Ri: entity msi.counter generic map(4) port map(clk, Li, LIi, to_unsigned(0,4), i);
  Rk: entity msi.counter generic map(KW) port map(clk, Lk, LIk, to_unsigned(0,KW), k);
  Ci: entity msi.comp generic map(4) port map(i, to_unsigned(11,4), open, i11, open);
  Ck: entity msi.comp generic map(KW) port map(k, to_unsigned(D-1,KW), open, kd, open);
end arch;  
