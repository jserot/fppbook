library ieee;
use ieee.std_logic_1164.all;

entity RX is
  generic(D: natural);
  port(
        h: in std_logic;
        rx: in std_logic;
        rxData: out std_logic_vector(7 downto 0);
        rxRdy: out std_logic;
        rxErr: out std_logic;
        rst: in std_logic
        );
end entity;

architecture RTL of RX is
  type t_state is ( Data, Parite, Repos, Stop, Sync );
  signal state: t_state;
begin
  process(rst, h)
    variable i: integer range 0 to 8;
    variable k: integer range 0 to D-1;
    variable r: std_logic_vector(7 downto 0);
    variable p: std_logic;
  begin
    if rst='1' then
      state <= Repos;
      rxRdy <= '1';
    elsif rising_edge(h) then 
      case state is
      when Repos =>
        if rx = '0' then
          k := 0;
          rxRdy <= '0';
          --assert false report "rx: got start" severity note;
          state <= Sync;
        end if;
      when Sync =>
        if k = D/2-1 then
          k := 0;
          i := 0;
          p := '0';
          --assert false report "rx: sync'ed" severity note;
          state <= Data;
        else
          k := k+1;
        end if;
      when Data =>
        if  k=D-1 then
          if i=8 then
            p := p xor rx;
            k := 0;
            state <= Parite;
          else -- k<8
            --assert false report "rx: r(" & integer'image(i) & ")=" & std_logic'image(rx) severity note;
            r(i) := rx;
            p := p xor rx;
            k := 0;
            i := i+1;
          end if;
        else -- k<D-1
          k := k+1;
        end if;
      when Parite =>
        if  k=D-1 then
          k := 0;
          state <= Stop;
        else
          k := k+1;
        end if;
      when Stop =>
        if  k=D-1 then
          rxData <= r;
          rxErr <= p;
          rxRdy <= '1';
          state <= Repos;
        else
          k := k+1;
        end if;
    end case;
    end if;
  end process;
end RTL;
