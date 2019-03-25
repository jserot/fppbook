library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.token.all;

entity display is
  port(
    num: in num_t;
    tag: in tag_t;
	ssd5: out std_logic_vector(7 downto 0); 
	ssd3: out std_logic_vector(7 downto 0); 
	ssd2: out std_logic_vector(7 downto 0);
	ssd1: out std_logic_vector(7 downto 0);
	ssd0: out std_logic_vector(7 downto 0) 
    );
end entity;

architecture rtl of display is

  function ssd(inp: std_logic_vector(3 downto 0)) return std_logic_vector is
  begin
    case inp is
      when "0000" => return "11000000" ;
      when "0001" => return "11111001" ;
      when "0010" => return "10100100" ;
      when "0011" => return "10110000" ;
      when "0100" => return "10011001" ;
      when "0101" => return "10010010" ;
      when "0110" => return "10000010" ;
      when "0111" => return "11111000" ;
      when "1000" => return "10000000" ;
      when "1001" => return "10011000" ;
      when "1010" => return "10001000" ;
      when "1011" => return "10000011" ;
      when "1100" => return "11000110" ;
      when "1101" => return "10100001" ;
      when "1110" => return "10000110" ;
      when "1111" => return "10001110" ;
      when others => return "01111111";
    end case;   
  end function;

begin
  ssd5 <= ssd(std_logic_vector(to_unsigned(tag_t'pos(tag),4)));
  ssd3 <= ssd(std_logic_vector(num(15 downto 12)));
  ssd2 <= ssd(std_logic_vector(num(11 downto 8)));
  ssd1 <= ssd(std_logic_vector(num(7 downto 4)));
  ssd0 <= ssd(std_logic_vector(num(3 downto 0)));
end architecture;
