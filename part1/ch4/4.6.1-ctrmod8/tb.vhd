library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end tb;
     
architecture beh of tb is

  component ctrmod8 is
    port (clk: in std_logic;
          rst: in std_logic;
          val: out unsigned(2 downto 0));
  end component;

  signal clk, rst: std_logic;
  signal val_ok1, val_err, val_ok2: unsigned(2 downto 0);

begin
   C1: entity work.ctrmod8(ok1) port map (clk => clk, rst => rst, val => val_ok1);
   C2: entity work.ctrmod8(err) port map (clk => clk, rst => rst, val => val_err);
   C3: entity work.ctrmod8(ok2) port map (clk => clk, rst => rst, val => val_ok2);
   Clock: process
     begin
      for i in 0 to 8 loop
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
        end loop;
        wait;
    end process;
   Stim: process
     begin
     rst <= '1';
     wait for 2 ns;
     rst <= '0';
     wait for 8 ns;
     wait for 60 ns;
     rst <= '1';
     wait for 2 ns;
     rst <= '0';
     wait;
    end process;
end beh;
