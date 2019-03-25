-- Listing 4.5

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity addbcd4 is
port(
  a3 : in unsigned(3 downto 0);
  a2 : in unsigned(3 downto 0);
  a1 : in unsigned(3 downto 0);
  a0 : in unsigned(3 downto 0);
  b3 : in unsigned(3 downto 0);
  b2 : in unsigned(3 downto 0);
  b1 : in unsigned(3 downto 0);
  b0 : in unsigned(3 downto 0);
  s4 : out unsigned(0 downto 0);
  s3 : out unsigned(3 downto 0);
  s2 : out unsigned(3 downto 0);
  s1 : out unsigned(3 downto 0);
  s0 : out unsigned(3 downto 0)
  );
  end entity;

architecture struct of addbcd4 is
  signal r1,r2,r3 : unsigned(0 downto 0);
begin
 add0: entity work.addbcd1 port map(a0, b0, "0", s0, r1);
 add1: entity work.addbcd1 port map(a1, b1, r1, s1, r2);
 add2: entity work.addbcd1 port map(a2, b2, r2, s2, r3);
 add3: entity work.addbcd1 port map(a3, b3, r3, s3, s4);
end architecture;
