library ieee;
use ieee.std_logic_1164.all;	   

entity uart is
  generic(D: natural := 4);
  port(
        H: in std_logic;
        rst: in std_logic;
        TxWr: in std_logic;
        TxData: in std_logic_vector(7 downto 0);
        TxRdy: out std_logic;
        Tx: out std_logic;
        RxRdy: out std_logic;
        RxData: out std_logic_vector(7 downto 0);
        RxErr: out std_logic;
        Rx: in std_logic
        );
end entity;

architecture struct of uart is
begin
  T: entity work.TX generic map (D) port map(H,TxData,TxWr,TxRdy,Tx,rst);
  R: entity work.RX generic map (D) port map(H,Rx,RxData,RxRdy,RxErr,rst);
end architecture;
