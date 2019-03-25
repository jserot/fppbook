library ieee;
use ieee.std_logic_1164.all;	   
use ieee.numeric_std.all;

entity tb is
end tb;

architecture seq of tb is

  
  signal h, rst: std_logic;
  signal sel: std_logic;
  signal xc: signed(7 downto 0);
  signal y: signed(15 downto 0);

begin

  U1: entity work.fir(rtl) generic map(3) port map(h, sel, xc, y, rst);
  
  CLOCK: process
  begin
    h<='1'; wait for 5 ns;
    h<='0'; wait for 5 ns;
  end process;

  RESET: process
  begin
    rst <= '1'; wait for 1 ns;
    rst <= '0';
    wait;
  end process;

  STIM: process
    type t_seq is array (natural range <>) of integer;
    constant xs : t_seq := (0, 2, 4, 6, -8, -6, 4, -2, 0 );
    constant cs : t_seq := (1, -1, 2);
  begin
  sel <= '0'; -- Coefficients
  wait for 5 ns;
  for i in cs'range loop
    xc <= to_signed(cs(i), 8);
    wait for 10 ns;
  end loop;
  sel <= '1'; -- Donnees
  for i in xs'range loop
    xc <= to_signed(xs(i), 8);
    wait for 10 ns;
  end loop;
  wait;
  end process;
end architecture;
