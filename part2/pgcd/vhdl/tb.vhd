-- Listing 5.3

library ieee;
use ieee.std_logic_1164.all;	   
use ieee.numeric_std.all;

entity tb is
end tb;

architecture arch of tb is

  signal m, n, r: unsigned(7 downto 0);
  signal clk, start, rdy, rst: std_logic;

begin
  UUT: entity work.pgcd(rtl) port map(clk, m, n, r, start, rdy, rst);
  
  CLOCK: process
  begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  RESET: process
  begin
    rst <= '1'; wait for 5 ns;
    rst <= '0';
    wait;
  end process;

  STIM: process
    type pattern_type is record
      m, n : integer; -- Inputs
      r : integer;    -- Expected output
    end record;

    type pattern_array is array (natural range <>) of pattern_type;

    constant patterns : pattern_array :=   -- Test patterns
      ((24, 30, 6),
       (12, 5, 1),
       (120, 96, 24),
       (96, 120, 24),
       (255, 255, 255));

  begin
    for i in patterns'range loop --  Apply and check each pattern.
      --  Set the inputs.
      m <= to_unsigned(patterns(i).m, 8);
      n <= to_unsigned(patterns(i).n, 8);
       -- Assert start
      wait for 10 ns;
      start <= '1';
      wait for 10 ns;
      start <= '0';
      --  Wait for the results.
      wait until rdy = '1';
      --  Check the outputs.
      wait for 5 ns;
      assert to_integer(r) = patterns(i).r report "bad result " severity error;
      wait for 20 ns;                  -- before next pattern
    end loop;
    assert false report "end of test" severity note;
    wait;
  end process;

end architecture;
