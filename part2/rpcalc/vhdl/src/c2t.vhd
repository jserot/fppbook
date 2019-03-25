library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.token.all;

entity c2t is
  port(
    clk_i: in std_logic;
    rst_i: in std_logic;
	rx_rd: out std_logic;
	rx_data: in character;
	rx_rdy: in std_logic;
    r_rdy: in std_logic;
    dout: out token_t; 
    e_rdy: out std_logic
    );
end entity;

architecture rtl of c2t is

  function char_to_num(c: character) return num_t is
  begin
      return mk_num(character'pos(c)-character'pos('0'));
  end;

  function char_to_token(c: character) return token_t is
    variable t: token_t;
  begin
    case c is
      when CR => t.tag := Enter; t.num := mk_num(0);
      when '+' => t.tag := Plus; t.num := mk_num(0);
      when '-' => t.tag := Minus; t.num := mk_num(0);
      when '*' => t.tag := Times; t.num := mk_num(0);
      when '/' => t.tag := Div; t.num := mk_num(0);
      when others => t.tag := Enter; t.num := mk_num(1);
      -- the last case does not happen if illegal input characters have been filtered out before
    end case;
    return t;
  end;

  function num_to_token(n: num_t) return token_t is
    variable t: token_t;
  begin
    t.tag := Number;
    t.num := n;
    return t;
  end;

  type t_state is (WaitC, Get, Lex, WriteNum, WriteTok, Sync1, Sync2);
  signal state: t_state;
  signal c: character;
  signal acc: num_t;
  signal num_p: boolean;

begin
  process (clk_i, rst_i) is
    variable t1, t2: token_t;
  begin
    if rst_i = '0' then
      state <= WaitC;
      rx_rd <= '0';
      e_rdy <= '0';
      acc <= mk_num(0);
      num_p <= false;
    elsif rising_edge(clk_i) then
      case state is
        when WaitC =>
          if rx_rdy = '1' then
            rx_rd <= '1';
            state <= Get;
          end if;
        when Get => 
          rx_rd <= '0';
          c <= rx_data;  
          state <= Lex;
        when Lex =>
          if c >= '0' and c <= '9' then -- Got a digit. Keep on reading
            acc <= resize(acc*mk_num(10)+char_to_num(c),num_size); 
            num_p <= true;
            state <= WaitC;
          elsif c=CR or c='+' or c='-' or c='*' or c='/' then
            t2 := char_to_token(c);
            if num_p then -- Number pending
              t1 := num_to_token(acc);
              state <= WriteNum; 
            else
              state <= WriteTok; 
            end if;
          else
            state <= WaitC; -- Ignore illegal character
          end if;
        when WriteNum =>
          if r_rdy = '1' then 
            dout <= t1;
            e_rdy <= '1';
            acc <= mk_num(0);
            state <= Sync1;
          end if;
        when Sync1 =>
          if r_rdy = '0' then
            e_rdy <= '0';
            state <= WriteTok;
          end if;
        when WriteTok => 
          if r_rdy = '1' then
            dout <= t2;
            e_rdy <= '1';
            --assert not trace report "c2t: wrote " & to_string(t2) severity note;
            state <= Sync2;
          end if;
        when Sync2 =>
          if r_rdy = '0' then
            e_rdy <= '0';
            num_p <= false;
            acc <= mk_num(0);
            state <= WaitC; 
          end if;
		end case;
      end if;
    end process;
end architecture;
