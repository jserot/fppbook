library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rx_pc is
  port (-- E/S
        clk: in std_logic;
        rst: in std_logic;
        rx: in std_logic;
        rxRdy: out std_logic;
        -- Interface avec la PO
        Lr: out std_logic;
        LSr: out std_logic;
        Li: out std_logic;
        LIi: out std_logic;
        Lk: out std_logic;
        LIk: out std_logic;
        selk: out std_logic;
        Ld: out std_logic;
        kd: in std_logic;
        i10: in std_logic
        );
end entity;

architecture fsm of rx_pc is
  type t_state is (Repos, Sync, Reception);
  signal state: t_state;
  --signal etat: integer range 0 to 2;
begin
  --etat <= t_state'pos(state);
  next_state: process(rst, clk)
  begin
    if rst = '1' then
      state <= Repos;
    elsif rising_edge(clk) then
      case state is
        when Repos =>
          if rx = '0' then
            state <= Sync;
          end if;
        when Sync =>
          if kd='1' then
            state <= Reception;
          end if;
        when Reception =>
          if i10='1' then
            state <= Repos;
          end if;
      end case;	    			
    end if;
  end process;		

  output: process (state, rx, kd, i10)
    begin
      case state is
        when Repos =>
          Li <= '0';
          LIi <= '0';
          Lk <= not rx;
          LIk <= '0';
          selk <= '0';
          Lr <= '0';
          LSr <= '0';
          Ld <= '0';
          rxRdy <= '1';
        when Sync =>
          Li <= not kd;
          LIi <= '0';
          Lk <= '1';
          LIk <= not kd;
          selk <= '0';
          Lr <= '0';
          LSr <= '0';
          Ld <= '0';
          rxRdy <= '0';
        when Reception =>
          Li <= kd and not i10;
          LIi <= '1';
          Lk <= not i10;
          LIk <= not kd;
          selk <= '1';
          Lr <= kd and not i10;
          LSr <= '1';
          Ld <= i10;
          rxRdy <= '0';
      end case;
  end process;
end architecture;
