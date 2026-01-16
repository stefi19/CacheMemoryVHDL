----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 05:20:00 PM
-- Design Name: 
-- Module Name: TB_topLevelModule - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench for topLevelModule (shows MISS then HIT)
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
use IEEE.NUMERIC_STD.ALL;

entity TB_cacheSystem is
end TB_cacheSystem;

architecture Behavioral of TB_cacheSystem is

signal addressBus: std_logic_vector(15 downto 0):=(others=>'0');
signal dataIn: std_logic_vector(7 downto 0):=(others=>'0');
signal cpuWr: std_logic:='0';
signal clk: std_logic:='0';
signal dataOut: std_logic_vector(7 downto 0);

component topLevelModule is
  Port ( 
    addressBus: in std_logic_vector(15 downto 0);
    dataIn: in std_logic_vector(7 downto 0);
    cpuWr: in std_logic;
    clk: in std_logic;
    dataOut: out std_logic_vector(7 downto 0)
  );
end component;

begin

uut: topLevelModule port map (addressBus=>addressBus, dataIn=>dataIn, cpuWr=>cpuWr, clk=>clk, dataOut=>dataOut);

clkProcess: process
begin
    clk<='0';
    wait for 5 ns;
    clk<='1';
    wait for 5 ns;
end process;

stimulusProcess: process
begin
    -- =========================================
    -- Test Case 1: Access 0x1234 (MISS -> UPDATE writes AA)
    -- =========================================
    cpuWr<='0';
    addressBus<=x"1234";
    dataIn<=x"AA";
    wait for 60 ns; -- give FSM time (SEARCH->UPDATE->RDWR + settle)

    -- =========================================
    -- Test Case 2: Access 0x1234 again (HIT -> should output AA)
    -- =========================================
    cpuWr<='0';
    addressBus<=x"1234";
    wait for 40 ns;

    -- =========================================
    -- Test Case 3: Access 0x12B4 (MISS -> UPDATE writes 55)
    -- =========================================
    cpuWr<='0';
    addressBus<=x"12B4";
    dataIn<=x"55";
    wait for 60 ns;

    -- =========================================
    -- Test Case 4: Access 0x12B4 again (HIT -> should output 55)
    -- =========================================
    cpuWr<='0';
    addressBus<=x"12B4";
    wait for 40 ns;

    -- =========================================
    -- Test Case 5: Go back to 0x1234 (should still HIT -> AA)
    -- =========================================
    cpuWr<='0';
    addressBus<=x"1234";
    wait for 40 ns;

    wait;

end process;

end Behavioral;
