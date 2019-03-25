library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package components is

component reg is
    generic (width: integer);
  port ( clk: in std_logic;
         ena: in std_logic;
         din: in std_logic_vector(width-1 downto 0);
         dout: out std_logic_vector(width-1 downto 0));
end component;

component counter is
  generic (width: integer := 8);
  port(clk: in std_logic;
       ena: in std_logic;
       li: in std_logic; -- li=0=>load, li=1=>incr
       din: in unsigned( width-1 downto 0 );
       dout: out unsigned( width-1 downto 0 )
       );
end component;

component shift_reg is
  generic (width: integer := 8);
  port(clk: in std_logic;
       ena: in std_logic;
       ls: in std_logic; -- ls=0=>load, ls=1=>shift
       lr: in std_logic; -- lr=0=>shift left, lr=1=>shift right
       din: in std_logic_vector(width-1 downto 0 );
       sin: in std_logic;
       dout: out std_logic_vector(width-1 downto 0 )
       );
end component;

component comp is
  generic (width: natural := 8);
  port ( a: in unsigned(width-1 downto 0);
         b: in unsigned(width-1 downto 0);
         lt: out std_logic;
         eq: out std_logic;
         gt: out std_logic);
end component;

component mux is
  generic (width: integer);
  port ( e0: in std_logic_vector(width-1 downto 0);
         e1: in std_logic_vector(width-1 downto 0);
         sel: in std_logic;
         s: out std_logic_vector(width-1 downto 0));
end component;

end package;
