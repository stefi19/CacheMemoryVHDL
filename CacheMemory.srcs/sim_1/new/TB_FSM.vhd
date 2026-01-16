----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 01:20:00 PM
-- Design Name: 
-- Module Name: TB_FSM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_FSM is
end TB_FSM;

architecture Behavioral of TB_FSM is

signal hit: std_logic:='0';
signal clk: std_logic:='0';
signal updateSignal: std_logic;
signal wr: std_logic;

component FSM is
  Port ( 
      hit: in STD_LOGIC;
      clk: in STD_LOGIC;
      updateSignal: out STD_LOGIC;
      wr: out STD_LOGIC
  );
end component;

begin

uut: FSM port map (hit=>hit, clk=>clk, updateSignal=>updateSignal, wr=>wr);

clkProcess: process
begin
    clk<='0';
    wait for 5 ns;
    clk<='1';
    wait for 5 ns;
end process;

stimulusProcess: process
begin
    --Test Case 1: hit='0' -> should go to UPDATE
    hit<='0';
    wait for 50 ns;
    
    --Test Case 2: hit='1' -> should go to RDWR
    hit<='1';
    wait for 50 ns;
    
    --Test Case 3: hit='0' again -> should go to UPDATE
    hit<='0';
    wait for 50 ns;
    
    --Test Case 4: hit='1' again -> should go to RDWR
    hit<='1';
    wait for 50 ns;
    
    wait;
    
end process;

end Behavioral;
