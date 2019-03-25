library ieee;
use ieee.std_logic_1164.all;	   
use ieee.numeric_std.all;	   

package token is

  constant num_size: natural := 16;
  
  subtype num_t is unsigned(num_size-1 downto 0);

  type tag_t is (Number, Enter, Plus, Minus, Times, Div);

  type token_t is record
    tag: tag_t;
    num: num_t; -- when tag=Number
  end record;

  function mk_num(n: integer) return num_t;
  function mk_tok(n: integer) return token_t;
  function mk_tok(t: tag_t) return token_t;
  function to_string(t: token_t) return string;
  function to_char(t: token_t) return character;
  function to_slv(t: token_t) return std_logic_vector; -- for debug

  type token_stream is array (natural range <>) of token_t;

end package;

package body token is

  function mk_num(n: integer) return num_t is
  begin
    return to_unsigned(n, num_size);
  end function;

  function mk_tok(n: integer) return token_t is
    variable t: token_t;
  begin
    t.tag := Number;
    t.num := mk_num(n);
    return t;
  end function;

  function mk_tok(t: tag_t) return token_t is
    variable r: token_t;
  begin
    r.tag := t;
    r.num := mk_num(0);
    return r;
  end function;

  function to_string(t: token_t) return string is
  begin
  case t.tag is
    when Number => return integer'image(to_integer(t.num));
    when Enter => return " ";
    when Plus => return "+";
    when Minus => return "-";
    when Times => return "*";
    when Div => return "/";
  end case;
end function;

  function to_char(t: token_t) return character is
  begin
  case t.tag is
    when Number => return 'n';
    when Enter => return CR;
    when Plus => return '+';
    when Minus => return '-';
    when Times => return '*';
    when Div => return '/';
  end case;
end function;

  function to_slv(t: token_t) return std_logic_vector is
  begin
  case t.tag is
    when Number => return "0000" & std_logic_vector(t.num(7 downto 0)); -- 0000xxxxxxxx
    when Enter => return  "000100000000"; -- 0x100
    when Plus => return   "001000000000"; -- 0x200
    when Minus => return  "001100000000"; -- 0x300
    when Times => return  "010000000000"; -- 0x400
    when Div => return    "010100000000"; -- 0x500
  end case;
end function;

end package body;
