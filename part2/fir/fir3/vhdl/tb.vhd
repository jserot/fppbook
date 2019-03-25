library ieee;
use ieee.std_logic_1164.all;	   
use ieee.numeric_std.all;

entity tb is
end tb;

architecture seq of tb is

  constant a0 : integer := 2;
  constant a1 : integer := -1;
  constant a2 : integer := 1;

  signal h, rst: std_logic;
  signal x: signed(7 downto 0);
  signal y: signed(15 downto 0);

begin

  UUT: entity work.fir3(rtl3)
    generic map(to_signed(a0,7), to_signed(a1,7), to_signed(a2,7))
    port map(h, x, y, rst);
  
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
    variable y_expected: integer;
  begin
    wait for 5 ns;
    for i in xs'range loop
      x <= to_signed(xs(i), 8);
      wait for 6 ns;
      if i > 1 then
        y_expected := xs(i)*a0+xs(i-1)*a1+xs(i-2)*a2;
        assert ( to_integer(y) = y_expected )
          report "error: expected: " & integer'image(y_expected) & " observed: " & integer'image(to_integer(y))
          severity error;
      end if;
      wait for 4 ns;
    end loop;
    assert false report "end of test" severity note;
    wait;
  end process;
end architecture;
