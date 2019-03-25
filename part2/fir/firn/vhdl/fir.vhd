library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package fir_types is
  type t_coeffs is array (natural range<>) of  signed (6 downto 0);
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.fir_types.all;

entity fir is
  generic (a: t_coeffs);
  port(
        h: in std_logic;
        x: in signed(7 downto 0);
        y: out signed(15 downto 0);
        rst: in std_logic
        );
end entity;

architecture rtl1 of fir is
  constant n: natural := a'length;
  type mem is array(0 to n-2) of signed(7 downto 0);
  signal z: mem;
begin
  process(rst, h)
    variable acc: signed(15 downto 0);
  begin
    if rst='1' then
      for i in 0 to n-2 loop
        z(i) <= to_signed(0,8);  
      end loop;
    elsif rising_edge(h) then 
      acc := resize(a(0),8) * x;
      for i in 1 to n-1 loop         -- Calcul ....
        acc := acc + resize(a(i),8)*z(i-1);
      end loop;
      y <= acc;                      -- ... puis ecriture de la sortie
      for i in 1 to n-2 loop         -- Mise a jour de z
        z(i) <= z(i-1);
      end loop;
      z(0) <= x;
    end if;
  end process;
end architecture;

architecture rtl2 of fir is
  constant n: natural := a'length;
  type mem is array(0 to n-2) of signed(7 downto 0);
  signal z: mem;
begin
  BUF: process(rst, h)
  begin
    if rst='1' then                -- INIT
      for i in 0 to n-2 loop
        z(i) <= to_signed(0,8);  
      end loop;
    elsif rising_edge(h) then      -- SHIFT RIGHT
      for i in 1 to n-2 loop       
        z(i) <= z(i-1);
      end loop;
      z(0) <= x;
    end if;
  end process;
  MAC: process(h)
    variable acc: signed(15 downto 0);
  begin
    if rising_edge(h) then   
      acc := resize(a(0),8) * x;
      for i in 1 to n-1 loop         
        acc := acc + resize(a(i),8)*z(i-1);
      end loop;
      y <= acc;                    
    end if;
  end process;
end architecture;

architecture rtl3 of fir is
  constant n: natural := a'length;
  type t_z is array(1 to n) of signed(7 downto 0);
  signal z: t_z;
  type t_acc is array(1 to n-1) of signed(15 downto 0);
  signal acc: t_acc;
begin
  TAP1: entity work.fir_tap generic map(a(0)) port map (h, x, z(1), to_signed(0,16), acc(1), rst);
  TAPs: for i in 2 to n-1 generate
    TAPi: entity work.fir_tap generic map(a(i-1)) port map (h, z(i-1), z(i), acc(i-1), acc(i), rst);
  end generate;
  TAPn: entity work.fir_tap generic map(a(n-1)) port map (h, z(n-1), z(n), acc(n-1), y, rst);
end architecture;
