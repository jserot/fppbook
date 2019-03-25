library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrmod8 is
  port (clk: in std_logic;
        rst: in std_logic;
        val: out unsigned(2 downto 0));
end entity;

architecture err of ctrmod8 is
  signal cnt: unsigned(2 downto 0);
begin
  COUNT: process (rst, clk)
  begin
    if rst='1' then
      cnt <= "000";
    elsif clk'event and clk='1' then
      cnt <= cnt+1;
    end if;
    val <= cnt;
  end process;
end architecture;

architecture ok1 of ctrmod8 is
  signal cnt: unsigned(2 downto 0);
begin
  COUNT: process (rst, clk)
  begin
    if rst='1' then
      cnt <= "000";
    elsif clk'event and clk='1' then
      cnt <= cnt+1;
    end if;
  end process;
  val <= cnt;
end architecture;

architecture ok2 of ctrmod8 is
begin
  COUNT: process (rst, clk)
    variable cnt : unsigned(2 downto 0);
  begin
    if rst='1' then
      cnt := "000";
    elsif clk'event and clk='1' then
      cnt := cnt+1;
    end if;
  val <= cnt;
  end process;
end architecture;
