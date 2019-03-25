library ieee ;
use ieee.std_logic_1164.all;

entity top is
 port(
    h: in std_logic;
    e: in std_logic;
  rst: in std_logic;
    s1: out std_logic;
    s2: out std_logic;
    s3: out std_logic);
end entity;

architecture struct of top is
begin
  U1: entity work.genimp(moore) port map(e=>e,h=>h,rst=>rst,s=>s1);
  U2: entity work.genimp(mealy) port map(e=>e,h=>h,rst=>rst,s=>s2);
  U3: entity work.genimp_g(mono) generic map(n=>4) port map(e=>e,h=>h,rst=>rst,s=>s3);
end architecture;
