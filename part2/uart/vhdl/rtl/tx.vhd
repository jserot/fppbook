library ieee;
use ieee.std_logic_1164.all;

entity TX is
  generic(D: natural);
  port( h: in std_logic;
        txData: in std_logic_vector(7 downto 0);
        txWr: in std_logic;
        txRdy: out std_logic;
        tx: out std_logic;
        rst: in std_logic
        );
end entity;

architecture RTL of TX is
  type t_state is ( Data, Parite, Repos, Start, Stop );
  signal state: t_state;
begin
  process(rst, h)
    variable r: std_logic_vector(7 downto 0);
    variable i: integer range 0 to 8;
    variable p: std_logic;
    variable k: integer range 0 to D-1;
  begin
    if rst='1'  then
      state <= Repos;
      txRdy <= '1';
      tx <= '1';
    elsif rising_edge(h) then 
      case state is
      when Repos =>
        if txWr = '1' then
          tx <= '0';
          k := 0;
          r := txData;
          txRdy <= '0';
          state <= Start;
        end if;
      when Start =>
        if  k=D-1 then
          tx <= r(0);
          p := r(0);
          i := 1;
          k := 0;
          state <= Data;
        else
          k := k+1;
        end if;
      when Data =>
        if  k=D-1 then
          if  i=8 then
            tx <= p;
            k := 0;
            state <= Parite;
          else -- i<8
            tx <= r(i);
            p := p xor r(i);
            i := i+1;
            k := 0;
          end if;
        else
          k := k+1;
        end if;
      when Parite =>
        if  k=D-1 then
          k := 0;
          tx <= '1';
          state <= Stop;
        else
          k := k+1;
        end if;
      when Stop =>
        if  k=D-1 then
          tx <= '1';
          txRdy <= '1';
          state <= Repos;
        else
          k := k+1;
        end if;
    end case;
    end if;
  end process;
end RTL;
