library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity r is
  port( h: in std_logic;
        e_rdy: in std_logic;
        v: in integer;
        r_rdy: out std_logic;
        dout: out integer;
        rst: in std_logic
        );
end r;

architecture RTL of r is
  type t_state is ( Att, R1, R2 );
  signal state: t_state;
  constant Dr: integer := 3; -- A modifier
begin
  process(rst, h)
    variable t: integer;
  begin
    if ( rst='1' ) then
      state <= R1;
      r_rdy <= '1';
    elsif rising_edge(h) then 
      case state is
      when R1 =>
        if ( e_rdy = '1' ) then
          dout <= v;
          r_rdy <= '0';
          state <= R2;
        end if;
      when R2 =>
        if ( e_rdy = '0' ) then
          t := 0;
          state <= Att;
        end if;
      when Att =>
        if ( t<Dr ) then
          t := t+1;
        elsif  ( t = Dr ) then
          r_rdy <= '1';
          state <= R1;
        end if;
    end case;
    end if;
  end process;
end RTL;
