library ieee;
use ieee.std_logic_1164.all;	   
use ieee.numeric_std.all;

entity top is
  port( H: in std_logic;
        dout: out integer;
        rst: in std_logic
        );
end entity;

architecture struct of top is
  signal e_rdy: std_logic;
  signal v: integer;
  signal r_rdy: std_logic;

begin
  U_E: entity work.E port map(H,r_rdy,v,e_rdy,rst);
  U_R: entity work.R port map(H,e_rdy,v,r_rdy,dout,rst);
end architecture;
