library ieee;
use ieee.std_logic_1164.all;	   

entity tb is
end tb;

architecture arch of tb is

  -- Temps de propagation dans le registre, la porte XOR et NOR resp.
  constant tp: time := 5 ns;
  constant tp1: time := 15 ns;
  constant tp2: time := 10 ns;
 
  constant th: time := 40 ns; -- Periode d'horloge pour les chronogrammes des figures 2.11 et 2.12
--  constant th: time := 18 ns; -- Periode d'horloge pour les chronogrammes des figures 2.15 et 2.16

  component dctrmod4
    generic (tp: time; tp1: time; tp2: time);
    port ( 
      h, rst : in std_logic; 
      S : out std_logic_vector(1 downto 0)); 
  end component;

  signal s: std_logic_vector(1 downto 0);
  signal h,rst: std_logic;

begin

  UUT: dctrmod4
    generic map (tp, tp1, tp2)
    port map(h,rst,s);
  
  CLOCK: process
  begin
    h <= '1';		
    wait for th/2;
    h <= '0';
    wait for th/2;
  end process;

  RESET: process
  begin
    rst <= '1'; 
    wait for 5 ns;
    rst <= '0'; 
    wait;
  end process;

end architecture;
