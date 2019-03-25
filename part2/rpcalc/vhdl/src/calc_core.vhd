library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.token.all;

entity calc_core is
  generic (trace: boolean := false);
  port(
        h: in std_logic;
        rst: in std_logic;
        e_rdy1: in std_logic;
        din: in token_t;
        r_rdy1: out std_logic;
        r_rdy2: in std_logic;
        dout: out token_t;
        e_rdy2: out std_logic;
        last_x: out num_t -- for debug
        );
end entity;

architecture RTL of calc_core is
  type t_state is ( R1, R2, Compute, E1, E2 );
  signal state: t_state;
  signal x, y, z: num_t; -- Compute stack
  signal l: boolean; -- Lift/no lift flag
begin
  last_x <= x; -- for debug
  process(rst, h)
    variable t, r: token_t;
  begin
    if rst = '0' then
      state <= R1;
      l <= false;
      r_rdy1 <= '1';
      e_rdy2 <= '0';
    elsif rising_edge(h) then 
      case state is
      when R1 =>
        if  e_rdy1 = '1' then
          t := din;
          assert not trace report "calc:got " & to_string(t) severity note;
          r_rdy1 <= '0';
          state <= R2;
        end if;
      when R2 =>
        if e_rdy1 = '0' then
          r_rdy1 <= '1';
          state <= Compute;
        end if;
      when Compute =>
        case t.tag is
          when Number =>
            if l then  -- Lift stack
              z <= y;
              y <= x;
            end if;
            x <= t.num;   -- Write on top
            state <= R1;  -- No output
          when Enter =>  -- Lift stack
            z <= y;
            y <= x;
            l <= false;
            state <= R1;  -- No output
          when Plus =>
            x <= y + x;
            y <= z;
            state <= E1;
          when Minus =>
            x <= y - x;
            y <= z;
            state <= E1;
          when Times =>
            x <= resize(y*x, num_size);
            y <= z;
            state <= E1;
          when Div =>
            x <= y / x;
            y <= z;
            state <= E1;
          end case;
      when E1 =>
        if r_rdy2 = '1' then
          r.num := x;
          r.tag := Number;
          dout <= r;
          e_rdy2 <= '1';
          assert not trace report "calc: wrote " & to_string(r) severity note;
          state <= E2;
        end if;
      when E2 =>
        if r_rdy2 = '0' then
          e_rdy2 <= '0';
          l <= true;
          state <= R1;
        end if;
    end case;
    end if;
  end process;
end architecture;
