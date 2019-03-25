library ieee;
use ieee.std_logic_1164.all;

entity shift_reg is
  generic (width: integer := 8);
  port(clk: in std_logic;
       ena: in std_logic;
       ls: in std_logic; -- ls=0=>load, ls=1=>shift
       lr: in std_logic; -- lr=0=>shift left, lr=1=>shift right
       din: in std_logic_vector(width-1 downto 0 );
       sin: in std_logic;
       dout: out std_logic_vector(width-1 downto 0 )
       );
end entity;

architecture arch of shift_reg is 
  signal r: std_logic_vector(width-1 downto 0); 
  begin 
    process (clk) 
      begin 
        if rising_edge(clk) then
          if ena = '1' then
            if ( ls = '0' ) then       -- LOAD
              r <= din;
            else                       -- SHIFT
              if ( lr = '0' ) then     --   LEFT
                r <= r(width-2 downto 0) & sin; 
              else                     --   RIGHT
                r <= sin & r(width-1 downto 1); 
              end if;
            end if; 
          end if; 
        end if; 
    end process; 
    dout <= r; 
end arch; 

