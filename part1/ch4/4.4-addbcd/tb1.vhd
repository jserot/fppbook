library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb1 is
end tb1;

architecture arch of tb1 is

  signal a, b, s1, s2: unsigned(3 downto 0);
  signal ci, co1, co2 : unsigned(0 downto 0);

begin
   U1: entity work.addbcd1(arch1) port map (a, b, ci, s1, co1);
   U2: entity work.addbcd1(arch2) port map (a, b, ci, s2, co2);
   process
           subtype digit is integer range 0 to 9;
           subtype carry is integer range 0 to 1;
           type pattern_type is record
              a, b : digit;
              cin: carry;
              cout: carry;
              s : digit;
           end record;
           type pattern_array is array (natural range <>) of pattern_type;
           constant patterns : pattern_array :=
             ((0, 0, 0, 0, 0),   -- 0+0+0=0 
              (8, 4, 0, 1, 2),   -- 8+4+0=12
              (9, 5, 1, 1, 5),   -- 9+5+1=15
              (9, 9, 0, 1, 8),   -- 9+9+0=18
              (9, 9, 1, 1, 9));  -- 9+9+1=19
        begin
           for i in patterns'range loop
              a <= to_unsigned(patterns(i).a,4);
              b <= to_unsigned(patterns(i).b,4);
              ci <= to_unsigned(patterns(i).cin,1);
              wait for 10 ns;
              assert to_integer(s1) = patterns(i).s and to_integer(co1) = patterns(i).cout 
                 report "bad sum value for U1" severity error;
              assert to_integer(s2) = patterns(i).s and to_integer(co2) = patterns(i).cout 
                 report "bad sum value for U2" severity error;
              wait for 10 ns;
           end loop;
           assert false report "end of test" severity note;
           wait;
        end process;
end architecture;
