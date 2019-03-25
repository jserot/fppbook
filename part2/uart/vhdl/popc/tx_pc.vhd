library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tx_pc is
  port (-- E/S
        clk: in std_logic;
        rst: in std_logic;
        txWr: in std_logic;
        txRdy: out std_logic;
        tx: out std_logic;
        -- Interface avec la PO
        Lr: out std_logic;
        LSr: out std_logic;
        Li: out std_logic;
        LIi: out std_logic;
        Lk: out std_logic;
        LIk: out std_logic;
        kd: in std_logic;
        i11: in std_logic;
        r0: in std_logic);
end entity;

architecture fsm of tx_pc is
  type t_state is (Repos, Emission);
  signal state : t_state;
begin
  next_state: process(rst, clk)
  begin
    if rst = '1' then
      state <= Repos;
    elsif rising_edge(clk) then
      case state is
        when Repos =>
          if txWr = '1' then
            state <= Emission;
          end if;
        when Emission =>
          if i11='1' then
            state <= Repos;
          end if;
      end case;	    			
    end if;
  end process;		

  output: process (state, txWr, kd, i11, r0)
    begin
      case state is
        when Repos =>
          Li <= txWr;
          LIi <= '0';
          Lk <= txWr;
          LIk <= '0';
          Lr <= txWr;
          LSr <= '0';
          txRdy <= '1';
          tx <= '1';
        when Emission =>
          Li <= kd and not i11;
          LIi <= '1';
          Lk <= not i11;
          LIk <= not kd;
          Lr <= kd and not i11;
          LSr <= '1';
          txRdy <= '0';
          tx <= r0;
      end case;
  end process;
end architecture;
