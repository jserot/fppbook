library ieee;
use ieee.std_logic_1164.all;

package data_types is
    subtype int8 is integer range 0 to 255;
    type int8_array is array(integer range <>) of int8;
end package;
