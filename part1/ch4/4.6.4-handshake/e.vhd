library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity e is
  port( h: in std_logic;
        r_rdy: in std_logic;
        v: out integer;
        e_rdy: out std_logic;
        rst: in std_logic
        );
end e;

architecture RTL of e is
  type t_state is ( Att, E1, E2 );
  signal state: t_state;
  constant De: integer := 1; -- A modifier
begin
  process(rst, h)
    variable t: integer;
    variable cnt: integer;
  begin
    if ( rst='1' ) then
      state <= E1;
      e_rdy <= '0';
      cnt := 1;
    elsif rising_edge(h) then 
      case state is
      when E1 =>
        if ( r_rdy = '1' ) then
          v <= cnt;
          cnt := cnt+1;
          e_rdy <= '1';
          state <= E2;
        end if;
      when E2 =>
        if ( r_rdy = '0' ) then
          e_rdy <= '0';
          t := 0;
          state <= Att;
        end if;
      when Att =>
        if ( t<De ) then
          t := t+1;
        elsif  ( t = De ) then
          state <= E1;
        end if;
    end case;
    end if;
  end process;
end RTL;
