library ieee;
use ieee.std_logic_1164.all;	   

entity tb is
end tb;

architecture arch of tb is

  signal e: std_logic;
  signal h: std_logic;
  signal rst: std_logic;
  signal s_moore, s_mealy1, s_mealy2: std_logic;

begin

  U1: entity work.genimp(moore) port map(e=>e,h=>h,rst=>rst,s=>s_moore);
  U2: entity work.genimp(mealy) port map(e=>e,h=>h,rst=>rst,s=>s_mealy1);
  U3: entity work.genimp(mealy_var) port map(e=>e,h=>h,rst=>rst,s=>s_mealy2);
  
  CLOCK: process
  begin
    h <= '1'; wait for 5 ns;
    h <= '0'; wait for 5 ns;
  end process;

  RESET: process
  begin
    rst <= '1'; wait for 5 ns;
    rst <= '0';
    wait;
  end process;

  STIM: process
  begin
    e <= '0'; wait for 15 ns;
    e <= '1'; wait for 10 ns;
    e <= '0'; wait for 40 ns;
    e <= '1'; wait for 80 ns;
    e <= '0'; 
    wait;
  end process;
end architecture;
