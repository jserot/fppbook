library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.token.all;

entity t2c is
  generic (
    n: natural; -- size in bits of the input number
    m: natural  -- number of output digits 
    );
  port(
    clk: in std_logic;
    rst: in std_logic;
    e_rdy: in std_logic;
    din: in token_t;
    r_rdy: out std_logic;
	tx_wr: out std_logic;
	tx_data: out character;
	tx_rdy: in std_logic
    );
end entity;

architecture rtl of t2c is

  function num_to_char(c: unsigned) return character is
  begin
    if c = "1111" then
      return CR;
    else
      return character'val(to_integer(c)+character'pos('0'));
    end if;
  end;

  type t_state is (Read, Sync, Conv, WriteNum1, WriteNum2, WriteCar1, WriteCar2);
  signal state: t_state;
  signal i: integer range 0 to n;
  signal j: integer range 0 to n+(m-1)*4;
  signal z: boolean;

begin
  process (clk, rst) is
    variable r: unsigned(n+m*4-1 downto 0);
    variable t: token_t;
  begin
    if rst = '0' then
      state <= Read;
      tx_wr <= '0';
      r_rdy <= '1';
    elsif rising_edge(clk) then
      case state is
        when Read =>  -- Wait for data to send
          if e_rdy = '1' then
            t := din;
            r_rdy <= '0';
            state <= Sync;
          end if;
        when Sync =>  -- Wait for sync
          if e_rdy = '0' then
            r_rdy <= '1';
            case t.tag is
            when Number =>
              r(n+m*4-1 downto n) := to_unsigned(0,m*4);
              r(n-1 downto 0) := t.num(n-1 downto 0);
              i <= 0;
              state <= Conv;
            when others =>
              state <= WriteCar1;
            end case;
          end if;
        when Conv =>
          if i < n then 
            for k in 0 to m-1 loop
              if r(k*4+n+3 downto k*4+n) > 4 then
                r(k*4+n+3 downto k*4+n) := r(k*4+n+3 downto k*4+n)+to_unsigned(3,4);
              end if;
            end loop;
            r := shift_left(r,1);
            i <= i+1;
          else -- i=n
            r(n-1 downto n-4) := "1111"; -- This will be the CR character 
            j <= n+(m-1)*4;
            z <= false;
            state <= WriteNum1;
          end if;
        when WriteNum1 =>
          if j = n-8 then -- We are left of last digit (r[n-1:n-4])
            state <= Read;
          elsif r(j+3 downto j) = 0 and z = false and j /= num_size then -- Skip leading 0's
            j <= j-4;
          else
            if tx_rdy = '1' then
              tx_data <= num_to_char(r(j+3 downto j));
              tx_wr <= '1';
              state <= WriteNum2;
            end if;
          end if;
        when WriteNum2 =>
          tx_wr <= '0';
          j <= j-4;
          z <= true;
          state <= WriteNum1;
        when WriteCar1 =>
          if tx_rdy = '1' then
            tx_data <= to_char(t);
            tx_wr <= '1';
            state <= WriteCar2;
          end if;
        when WriteCar2 =>
          tx_wr <= '0';
          state <= Read;
		end case;
      end if;
    end process;
end architecture;
