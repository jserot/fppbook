library ieee;
use ieee.std_logic_1164.all;	   
use ieee.numeric_std.all;	   
use work.shreg_types.all;	   
use work.shreg_types_g.all;	   

entity tb is
end tb;

architecture seq of tb is

  signal clk: std_logic;
  signal rst: std_logic;
  signal din1: std_logic;
  signal dout1: std_logic_vector(0 to 3);
  signal din2: std_logic_vector(7 downto 0);
  signal dout2: array4_slv8;
  signal dout3: std_logic_vector(0 to 3);
  signal dout4: array_slv8(0 to 3);

begin

  U1: entity work.shreg(rtl) port map(clk, rst, din1, dout1);
  U2: entity work.shreg_v(rtl) port map(clk, rst, din2, dout2);
  U3: entity work.shreg_g(rtl) generic map(4) port map(clk, rst, din1, dout3);
  U4: entity work.shreg_vg(rtl) generic map(4) port map(clk, rst, din2, dout4);
  
  CLOCK: process
  begin
    clk<='1'; wait for 5 ns;
    clk<='0'; wait for 5 ns;
  end process;

  RESET:process
  begin
    rst <= '1'; wait for 2 ns;
    rst <= '0'; wait;
  end process;

  STIM1:process
    type pattern_array is array (natural range <>) of std_logic;
    constant patterns : pattern_array := ('0', '0', '1', '1', '1', '1', '0', '0', '0');
  begin
    din1 <= '0';
    wait for 5 ns; 
    for i in patterns'range loop
      din1 <= patterns(i);
      wait for 10 ns; 
    end loop;
    wait;
  end process;

  STIM2:process
  begin
    din2 <= "00000000";
    wait for 5 ns; 
    for i in 1 to 6 loop
      din2 <= std_logic_vector(to_unsigned(i, 8));
      wait for 10 ns; 
    end loop;
    wait;
  end process;

end architecture;
