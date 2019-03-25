library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.img_types.all;
use work.conv33_types.all;
use work.msfl_types.all;

entity top is
  port(
        h: in std_logic;
        rst: in std_logic;
        data_i: in pixel8;
        fval_i: in std_logic;
        dval_i: in std_logic;
        data_o: out pixel8;
        fval_o: out std_logic;
        dval_o: out std_logic
        );
end entity;

architecture struct of top is

constant im_width : positive := 512;
constant im_height : positive := 512;
constant w_width : positive := 3;
constant w_height : positive := 3;
constant coeffs: t_coeffs :=
  ((to_unsigned(1,8),to_unsigned(2,8),to_unsigned(1,8)),
   (to_unsigned(2,8),to_unsigned(4,8),to_unsigned(2,8)),
   (to_unsigned(1,8),to_unsigned(2,8),to_unsigned(1,8)));
constant normf: natural := 16;

begin
  C: entity work.conv33
     generic map(coeffs, normf, im_width, im_height, 2)
     port map(h, rst, data_i, fval_i, dval_i, data_o, fval_o, dval_o);
end architecture;
