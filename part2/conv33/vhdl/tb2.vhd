library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.img_types.all;
use work.conv33_types.all;
use work.msfl_types.all;

entity tb2 is
end tb2;

architecture arch of tb2 is

-- Test case #1
-- constant src_file: string := "./square4.pgm";
-- constant im_width : positive := 4;
-- constant im_height : positive := 4;
-- constant w_width : positive := 3;
-- constant w_height : positive := 3;
-- constant coeffs: t_coeffs :=
--   ((to_unsigned(0,8),to_unsigned(0,8),to_unsigned(0,8)),
--    (to_unsigned(0,8),to_unsigned(1,8),to_unsigned(0,8)),
--    (to_unsigned(0,8),to_unsigned(0,8),to_unsigned(0,8)));
-- constant normf: natural := 1;

-- Test case #2
constant src_file: string := "./lena128.pgm";
constant dst_file: string := "./res.pgm";
constant im_width : positive := 128;
constant im_height : positive := 128;
constant w_width : positive := 3;
constant w_height : positive := 3;
constant coeffs: t_coeffs :=
  ((to_unsigned(1,8),to_unsigned(2,8),to_unsigned(1,8)),
   (to_unsigned(2,8),to_unsigned(4,8),to_unsigned(2,8)),
   (to_unsigned(1,8),to_unsigned(2,8),to_unsigned(1,8)));
constant normf: natural := 16;

signal clk: std_logic;
signal rst: std_logic;
signal data_i: pixel8;
signal fval_i, dval_i: std_logic;
signal data_o: pixel8;
signal fval_o, dval_o: std_logic;

begin
  I: entity work.pgm_read
      generic map ( filename => src_file, pixel_depth => 8, line_blanking => 2, inter_frame => 2)
      port map( clk => clk, rst => rst, data => data_i, fval => fval_i, dval => dval_i); 

  C: entity work.conv33
     generic map(coeffs, normf, im_width, im_height, 2)
     port map(clk, rst, data_i, fval_i, dval_i, data_o, fval_o, dval_o);

  O: entity work.pgm_write
    generic map ( filename => dst_file, pixel_depth => 8, im_width => im_width, im_height => im_height, maxv => 255)
    port map( clk => clk, rst => rst, data => data_o, fval => fval_o, dval => dval_o);

RESET: process                   
begin
  rst <= '0'; wait for 1 ns;
  rst <= '1'; wait;
end process;

CLOCK: process                    
begin
  clk <= '1'; wait for 5 ns;
  clk <= '0'; wait for 5 ns;
end process;

end architecture;
