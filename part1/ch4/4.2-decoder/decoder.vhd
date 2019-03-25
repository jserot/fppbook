library ieee;
use ieee.std_logic_1164.all;

entity decoder is
   port
   ( X : in std_logic_vector(1 downto 0);
     Y : out std_logic_vector(0 to 3)
   );
end entity;

architecture erreur of decoder is
begin
   Y <= "1000" when X="00" else
        "0100" when X="01" else
        "0010" when X="10" else
        "0001" when X="11";  -- Oubli delibere du else ici...
end architecture;

architecture ok of decoder is
begin
   Y <= "1000" when X="00" else
        "0100" when X="01" else
        "0010" when X="10" else
        "0001" when X="11" else
        "XXXX";
end architecture;

