library ieee;
use ieee.std_logic_1164.all;

entity dctrmod4 is 
  generic (tp: time := 5 ns; tp1: time := 15 ns; tp2: time := 10 ns);
port ( 
 H, rst : in std_logic; 
 S : out std_logic_vector(1 downto 0)); 
end; 

architecture Moore of dctrmod4 is
signal x, xs: std_logic_vector(1 downto 0); 
begin 
 F: process (x) 
  begin 
      if ( x = "00" ) then 
       xs(1) <= '0' after tp1;    
       xs(0) <= '1' after tp2;
      elsif ( x = "01") then
       xs(1) <= '1' after tp1;    
       xs(0) <= '0' after tp2;    
     elsif ( x = "10") then 
       xs(1) <= '1' after tp1;    
       xs(0) <= '1' after tp2;
     else
       xs(1) <= '0' after tp1;
       xs(0) <= '0' after tp2;
     end if;
 end process; 
 G: process (x)
   begin
     if ( x = "00" ) then
        s <= "11" after tp2;
     elsif ( x = "01") then
        s <= "10" after tp2;
     elsif ( x = "10") then 
        s <= "01" after tp2;
     else
        s <= "00" after tp2;
     end if;
   end process; 
 Seq: process (H,rst) 
  begin 
    if ( rst = '1' ) then
      x <= "00";
    elsif ( rising_edge(H) ) then 
       x <= xs after tp;    
    end if ; 
 end process; 
end Moore;
