library ieee ;
use ieee.std_logic_1164.all;

entity fadd is
  port (a: in std_logic;
        b: in std_logic;
        ci: in std_logic;
        s: out std_logic;
        co: out std_logic);
end fadd;

architecture arch of fadd is
begin
  s <= a xor b xor ci;
  co <= (a and b) or (a and ci) or (b and ci);
end arch;
