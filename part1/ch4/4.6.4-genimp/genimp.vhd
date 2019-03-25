-- Listings 4.11, 4.12 et 4.13

library ieee ;
use ieee.std_logic_1164.all;

entity genimp is
 port(
    h: in std_logic;
    e: in std_logic;
  rst: in std_logic;
    s: out std_logic);
end entity;

architecture moore of genimp is
  type t_state is (R, T1, T2, T3);
  signal state: t_state;
begin
 NEXT_STATE: process (h, rst)
 begin
   if rst = '1' then
     state <= R;
   elsif rising_edge(h) then
     case state is
       when R =>
         if  e = '1' then
           state <= T1;
         else
           state <= R;
         end if;
       when T1 => state <= T2;
       when T2 => state <= T3;
       when T3 => state <= R;
     end case;
   end if;
  end process;
  OUTPUT: process (state)
  begin
    case state is
      when R => s <= '0';
      when others => s <= '1';
    end case;
  end process;
end architecture;

architecture mealy of genimp is
 type t_state is (R,T1,T2,T3);
 signal state: t_state;
begin
 process(h, rst)
 begin
  if ( rst = '1' ) then
    state <= R;
    s <= '0';
  elsif rising_edge(H) then
   case state is
     when R =>
      if ( e='1' ) then
        s <= '1';
        state <= T1;
      end if;
     when T1 => state <= T2;
     when T2 => state <= T3;
     when T3 =>
       s <= '0';
       state <= R;
    end case;
   end if;
  end process;
end architecture;

architecture mealy_var of genimp is
 type t_state is (R,T);
 signal state: t_state;
 signal k : natural range 1 to 3;
begin
 process(h, rst)
 begin
  if ( rst = '1' ) then
    state <= R;
    S <= '0';
  elsif rising_edge(H) then
   case state is
     when R =>
      if ( e='1' ) then
        state <= T;
        S <= '1';
        k <= 1;
      end if;
     when T =>
       if ( k = 3 ) then
         state <= R;
          S <= '0';
       else
         k <= k+1;
       end if;
    end case;
   end if;
  end process;
end architecture;
