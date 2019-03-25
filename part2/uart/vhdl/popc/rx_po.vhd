library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
library msi;
use msi.components.all;

entity rx_po is
  generic(D: natural);
  port (-- E/S
        clk: in std_logic;
        rx: in std_logic;
        rxData: out std_logic_vector(7 downto 0);
        rxErr: out std_logic;
        -- Interface avec la PC
        Lr: in std_logic;
        LSr: in std_logic;
        Li: in std_logic;
        LIi: in std_logic;
        Lk: in std_logic;
        LIk: in std_logic;
        selk: in std_logic;
        Ld: in std_logic;
        kd: out std_logic;
        i10: out std_logic);
end entity;

architecture arch of rx_po is

  function Parite(x: std_logic_vector(8 downto 0)) return std_logic is
  begin
    return x(8) xor x(7) xor x(6) xor x(5) xor x(4)
       xor x(3) xor x(2) xor x(1) xor x(0);
  end Parite;

  constant KW: natural := integer(ceil(log2(real(D))+0.5));

  signal r: std_logic_vector(9 downto 0);
  signal d_out: std_logic_vector(8 downto 0);
  signal i: unsigned(3 downto 0);
  signal k, kc: unsigned(KW-1 downto 0);

begin
  rxData <= d_out(7 downto 0);
  rxErr <= Parite(d_out(8 downto 0));
  Rr: entity msi.shift_reg
      generic map(10) port map(clk, Lr, LSr, '1', "0000000000", rx, r);
  Ri: entity msi.counter generic map(4) port map(clk, Li, LIi, to_unsigned(0,4), i);
  Rk: entity msi.counter generic map(KW) port map(clk, Lk, LIk, to_unsigned(0,KW), k);
  Rd: entity msi.reg generic map(9) port map(clk, Ld, r(8 downto 0), d_out);
  Ci: entity msi.comp generic map(4) port map(i, to_unsigned(10,4), open, i10, open);
  Mk: entity msi.mux generic map(KW) port map (to_unsigned(D/2-1,KW), to_unsigned(D-1,KW), selk, kc);
  Ck: entity msi.comp generic map(KW) port map(k, kc, open, kd, open);
end architecture;  
