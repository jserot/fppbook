-- Basic testbench, with inline generation of a small test image

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.img_types.all;
use work.conv33_types.all;
use work.msfl_types.all;

entity tb1 is
end tb1;

architecture arch of tb1 is

constant im_width : positive := 4;
constant im_height : positive := 4;
constant w_width : positive := 3;
constant w_height : positive := 3;
constant h_blank : positive := 2;
constant coeffs: t_coeffs :=
  ((to_unsigned(0,8),to_unsigned(0,8),to_unsigned(0,8)),
   (to_unsigned(0,8),to_unsigned(1,8),to_unsigned(0,8)),
   (to_unsigned(0,8),to_unsigned(0,8),to_unsigned(0,8)));
constant normf: natural := 1;

signal clk: std_logic;
signal rst: std_logic;
signal data_i: pixel8;
signal fval_i, dval_i: std_logic;
signal data_o: pixel8;
signal fval_o, dval_o: std_logic;

begin
  C: entity work.conv33
     generic map(coeffs, normf, im_width, im_height, h_blank)
     port map(clk, rst, data_i, fval_i, dval_i, data_o, fval_o, dval_o);

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

  STIM: process
  begin
    fval_i <= '0';
    dval_i <= '0';
    wait for 20 ns;
    fval_i <= '1'; -- Start of frame
    for i in 1 to im_height loop
      dval_i <= '1'; -- Start of line
      for j in 1 to im_width loop
        data_i <= to_unsigned(i*10+j, 8); -- Pixel
        wait for 10 ns;
      end loop;
      dval_i <= '0';
      data_i <= to_unsigned(0, 8);
      if i < im_width then
        wait for h_blank * 10 ns; -- Horizontal blanking (inter-line)
      end if;
    end loop;
    fval_i <= '0';
    wait;
  end process;

end architecture;
