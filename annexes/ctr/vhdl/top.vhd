library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
  generic (width: natural := 8; divf: natural := 3);
  port (ck: in std_logic;
        rst: in std_logic;
        cnt: out std_logic_vector(width-1 downto 0));
end entity;
     
architecture arch of top is
  signal cki: std_logic;
begin
   D: entity work.freqdiv generic map (divf) port map (ck, cki);
   C: entity work.counter generic map (width) port map (cki, rst, cnt);
end architecture;
