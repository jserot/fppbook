library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.img_types.all;
use work.msfl_types.all;
use work.conv33_types.all;

-- DATA_i and COEFFS :
--
-- +-----+-----+-----+
-- + 2,2 + 2,1 | 2,0 |
-- +-----+-----+-----+
-- + 1,2 + 1,1 | 1,0 |
-- +-----+-----+-----+
-- + 0,2 + 0,1 | 0,0 |
-- +-----+-----+-----+
--

entity conv33 is
  generic (
    coeffs: t_coeffs;
    normf: integer  := 1;
    im_width: positive;
    im_height: positive;
    hblank: positive
    );
  port (
    clk: in  std_logic;
    rst: in  std_logic;
    data_i: in pixel8;
    fval_i: in std_logic;
    dval_i: in std_logic;
    data_o: out pixel8;
    fval_o: out std_logic;
    dval_o: out std_logic
    );
end entity;

architecture struct of conv33 is
  signal data_m: pixel8_bundle(0 to 2, 0 to 2);
  signal fval_m, dval_m: std_logic;
  signal data_c: pixel8;
  signal fval_c, dval_c: std_logic;
begin
  M: entity work.msfl
    generic map(3, 3, im_width, im_height)
    port map( clk, rst, data_i, fval_i, dval_i, data_m, fval_m, dval_m);

  C: entity work.conv33_op
    generic map(coeffs, normf)
    port map(clk, rst, data_m, fval_m, dval_m, data_c, fval_c, dval_c);

  S: entity work.shift33
    generic map(im_width, im_height, hblank)
    port map(clk, rst, data_c, fval_c, dval_c, data_o, fval_o, dval_o);

end;
