-- Listing 5.2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pgcd is
  port(	clk: 	in std_logic;
        m:	in unsigned(7 downto 0);
        n:	in unsigned(7 downto 0);
        r:	out unsigned(7 downto 0);
        start:	in std_logic;
        rdy:	out std_logic;
        rst:	in std_logic
        );
end pgcd;

architecture rtl of pgcd is
  type t_state is (Repos, Calcul);
  signal etat: t_state;
  signal a, b: unsigned(7 downto 0);
begin
  process(rst, clk)
  begin
    if (rst='1') then
      etat <= Repos;
      rdy <= '1';
    elsif rising_edge(clk) then
      case etat is
        when Repos =>
          if (start='1') then
            a <= m;
            b <= n;
            etat <= Calcul;
            rdy <= '0';
          end if;
        when Calcul =>
          if ( a = b ) then
            r <= a;
            rdy <= '1';   
            etat <= Repos;
          elsif ( a > b ) then
            a <= a-b;
          else
            b <= b-a;
          end if;
      end case;	    			
    end if;
  end process;		
end architecture;

architecture rtl2 of pgcd is
  -- Variante avec la sortie [rdy] associee a l'etat
  type t_state is (Repos, Calcul);
  signal etat: t_state;
  signal a, b: unsigned(7 downto 0);
begin
  P1: process(rst, clk)
  begin
    if (rst='1') then
      etat <= Repos;
    elsif rising_edge(clk) then
      case etat is
        when Repos =>
          if (start='1') then
            a <= m;
            b <= n;
            etat <= Calcul;
          end if;
        when Calcul =>
          if ( a = b ) then
            r <= a;
            etat <= Repos;
          elsif ( a > b ) then
            a <= a-b;
          else
            b <= b-a;
          end if;
      end case;	    			
    end if;
  end process;		
  P2: process (etat)
  begin
    case etat is
      when Repos => rdy <= '1';
      when Calcul => rdy <= '0';
    end case;
  end process;
end architecture;
