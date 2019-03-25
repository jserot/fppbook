-- Listings 4.21

library ieee ;
use ieee.std_logic_1164.all;

entity genimp_g is
 generic (n: positive);
 port(
    h: in std_logic;
    e: in std_logic;
  rst: in std_logic;
    s: out std_logic);
end entity;

architecture mono of genimp_g is
  type t_state is (R, T);
  signal state: t_state;
  signal k: natural range 1 to n;
begin
 process (h, rst)
 begin
   if rst = '1' then
     state <= R;
     s <= '0';
   elsif rising_edge(h) then
     case state is
       when R =>
         if  e = '1' then
           state <= T;
           s <= '1';
           k <= 1;
         end if;
       when T =>
         if ( k = n ) then
           state <= R;
           s <= '0';
         else
           k <=k+1;
         end if;
     end case;
   end if;
  end process;
end architecture;

