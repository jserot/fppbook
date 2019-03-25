library ieee;
use ieee.std_logic_1164.all;

entity tb is
end tb;

architecture arch of tb is
  signal a, b, ci, s, co : std_logic;
begin
  UUT: entity work.fadd port map (a => a, b => b, ci => ci, s => s, co => co);

  STIM: process
    type pattern_type is record
      a, b, ci : std_logic;
      s, co : std_logic;
    end record;
    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
      (('0', '0', '0', '0', '0'),
       ('0', '0', '1', '1', '0'),
       ('0', '1', '0', '1', '0'),
       ('0', '1', '1', '0', '1'),
       ('1', '0', '0', '1', '0'),
       ('1', '0', '1', '0', '1'),
       ('1', '1', '0', '0', '1'),
      ('1', '1', '1', '1', '1'));
    begin
      for i in patterns'range loop
      a <= patterns(i).a;
      b <= patterns(i).b;
      ci <= patterns(i).ci;
      wait for 10 ns;
      assert s=patterns(i).s and co=patterns(i).co
        report "** erreur pattern " & integer'image(i)
        severity error;
    end loop;
    assert false report "end of test" severity note;
    wait;
  end process;
end architecture;
