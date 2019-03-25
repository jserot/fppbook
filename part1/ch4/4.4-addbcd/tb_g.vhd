library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.addbcd_types.all;

entity tb_g is
end tb_g;

architecture beh of tb_g is

  subtype digit is integer range 0 to 9;
  type    pattern_type is record
    a3, a2, a1, a0, b3, b2, b1, b0 : digit;
    s4, s3, s2, s1, s0             : digit;
  end record;
  type     pattern_array is array (natural range <>) of pattern_type;
  constant patterns : pattern_array :=
    ((0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),   -- 0000 + 0000 = 00000
     (0, 0, 0, 9, 0, 0, 0, 2, 0, 0, 0, 1, 1),   -- 0009 + 0002 = 00011
     (0, 0, 9, 9, 0, 0, 2, 0, 0, 0, 1, 1, 9),   -- 0099 + 0020 = 00119
     (0, 9, 9, 9, 0, 0, 0, 1, 0, 1, 0, 0, 0),   -- 0999 + 0001 = 01000
     (9, 9, 9, 9, 0, 0, 0, 2, 1, 0, 0, 0, 1));  -- 9999 + 0002 = 10001

  procedure check_result(p: pattern_type; s: array_u4; s4: unsigned(0 downto 0)) is
  begin
    assert to_integer(s4) = p.s4 and to_integer(s(3)) = p.s3
        and to_integer(s(2)) = p.s2 and to_integer(s(1)) = p.s1
        and to_integer(s(0)) = p.s0
        report "bad result. Expected="
          & integer'image(p.s4) & integer'image(p.s3) & integer'image(p.s2) & integer'image(p.s1) & integer'image(p.s0)
          & " Observed="
          & integer'image(to_integer(s4)) & integer'image(to_integer(s(3))) & integer'image(to_integer(s(2)))
          & integer'image(to_integer(s(1))) & integer'image(to_integer(s(0)))
       severity error;
  end procedure;

  signal a: array_u4(3 downto 0);
  signal b: array_u4(3 downto 0);
  signal s: array_u4(3 downto 0);
  signal co: unsigned(0 downto 0);

begin

  U : entity work.addbcd generic map (4) port map (a, b, s, co);

  process
  begin
    for i in patterns'range loop
      a(3) <= to_unsigned(patterns(i).a3, 4);
      a(2) <= to_unsigned(patterns(i).a2, 4);
      a(1) <= to_unsigned(patterns(i).a1, 4);
      a(0) <= to_unsigned(patterns(i).a0, 4);
      b(3) <= to_unsigned(patterns(i).b3, 4);
      b(2) <= to_unsigned(patterns(i).b2, 4);
      b(1) <= to_unsigned(patterns(i).b1, 4);
      b(0) <= to_unsigned(patterns(i).b0, 4);
      wait for 20 ns;
      check_result(patterns(i), s, co);
      wait for 20 ns;
    end loop;
    assert false report "end of test" severity note;
    wait;
  end process;
end beh;
