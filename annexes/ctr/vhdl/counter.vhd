library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
  generic (
    width: natural := 8
    );
  port (
    clk: in std_logic;
    rst: in std_logic;
    val: out std_logic_vector(width-1 downto 0)
    );
end entity;

architecture rtl of counter is
  signal cnt: unsigned(width-1 downto 0);
begin
  process (clk, rst) is
  begin
    if rst = '0' then
        cnt <= to_unsigned(0, width);
    elsif rising_edge(clk) then
      cnt <= cnt+1;
    end if;
  end process;
  val <= std_logic_vector(cnt);
end architecture;
