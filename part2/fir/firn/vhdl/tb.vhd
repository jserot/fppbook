library ieee;
use ieee.std_logic_1164.all;	   
use ieee.numeric_std.all;
use work.fir_types.all;

entity tb is
end tb;

architecture seq of tb is

  constant a1 : t_coeffs := (to_signed(2,7), to_signed(-1,7), to_signed(1, 7));
  constant a2 : t_coeffs := (to_signed(1,7), to_signed(1,7), to_signed(1, 7), to_signed(1,7), to_signed(1,7));
  
  signal h, rst: std_logic;
  signal x: signed(7 downto 0);
  signal y1, y2: signed(15 downto 0);

begin

  -- U1: entity work.fir(rtl1) generic map(a1) port map(h, x, y1, rst);
  -- U1: entity work.fir(rtl1) generic map(a2) port map(h, x, y1, rst);
  -- U2: entity work.fir(rtl1) generic map(a2) port map(h, x, y2, rst);
  -- U2: entity work.fir(rtl2) generic map(a1) port map(h, x, y2, rst);
  -- U2: entity work.fir(rtl3) generic map(a1) port map(h, x, y2, rst);
  U1: entity work.fir(rtl3) generic map(a1) port map(h, x, y1, rst);
  U2: entity work.fir(rtl3) generic map(a2) port map(h, x, y2, rst);
  
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
    -- constant n1: natural := a1'length;
    -- constant n2: natural := a2'length;
    type t_seq is array (natural range <>) of integer;
    constant xs : t_seq := (0, 2, 4, 6, -8, -6, 4, -2, 0 );
    -- variable y1_expected, y2_expected: integer;
  begin
  wait for 5 ns;
    for i in xs'range loop
      x <= to_signed(xs(i), 8);
      wait for 1 ns;
      -- if i > n-2 then
      --   y_expected := 0;
      --   for j in 0 to n-1 loop
      --     y_expected := y_expected + to_integer(a(j))*xs(i-j);
      --   end loop;
      --   assert ( to_integer(y) = y_expected )
      --     report "error: expected: " & integer'image(y_expected) & " observed: " & integer'image(to_integer(y))
      --     severity error;
      -- end if;
      wait for 9 ns;
    end loop;
    assert false report "end of test" severity note;
    wait;
  end process;
end architecture;
