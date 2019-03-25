library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
  generic (width: integer := 8);
  port(	clk: in std_logic;
        ena: in std_logic;
        li: in std_logic; -- li=0=>load, li=1=>incr
        din: in unsigned( width-1 downto 0 );
        dout: out unsigned( width-1 downto 0 )
        );
end entity;

architecture arch of counter is 
  signal r: unsigned(width-1 downto 0); 
  begin 
    process (clk) 
      begin 
        if rising_edge(clk) then
          if ena = '1' then
            if ( li = '0' ) then -- LOAD
              r <= din;
            else                 -- COUNT
              r <= r+1;
            end if; 
          end if; 
        end if; 
    end process; 
    dout <= r;
end arch; 
