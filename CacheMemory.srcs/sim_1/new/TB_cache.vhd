----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 03:40:00 PM
-- Design Name: 
-- Module Name: TB_cache - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench for cache256 (clean waveform + recheck first line)
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

entity TB_cache is
end TB_cache;

architecture Behavioral of TB_cache is

signal addressBus: std_logic_vector(15 downto 0):=(others=>'0');
signal update: std_logic:='0';
signal wr: std_logic:='0';
signal clk: std_logic:='0';
signal dataIn: std_logic_vector(7 downto 0):=(others=>'0');
signal tagIn: std_logic_vector(7 downto 0):=(others=>'0');
signal dataOut: std_logic_vector(7 downto 0);
signal hitOut: std_logic;

component cache256 is
  Port ( 
    addressBus: in std_logic_vector (15 downto 0);
    update: in std_logic;
    wr: in std_logic;
    clk: in std_logic;
    dataIn: in std_logic_vector(7 downto 0);
    tagIn: in std_logic_vector(7 downto 0);
    dataOut: out std_logic_vector(7 downto 0);
    hitOut: out std_logic
  );
end component;

begin

uut: cache256 port map (addressBus=>addressBus, update=>update, wr=>wr, clk=>clk, dataIn=>dataIn, tagIn=>tagIn, dataOut=>dataOut, hitOut=>hitOut);

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
    -- Test Case 1: MISS + UPDATE (write full block for 0x1234)
    -- =========================================
    update<='1';
    wr<='1';
    tagIn<=x"12";

    addressBus<=x"1234"; dataIn<=x"AA"; wait for 10 ns;
    addressBus<=x"1235"; dataIn<=x"BB"; wait for 10 ns;
    addressBus<=x"1236"; dataIn<=x"CC"; wait for 10 ns;
    addressBus<=x"1237"; dataIn<=x"DD"; wait for 10 ns;

    -- disable update/write and go directly to first read address
    update<='0';
    wr<='0';
    addressBus<=x"1234";
    wait for 30 ns;

    -- =========================================
    -- Test Case 2: HIT reads for 0x1234 block
    -- =========================================
    addressBus<=x"1234"; wait for 20 ns;
    addressBus<=x"1235"; wait for 20 ns;
    addressBus<=x"1236"; wait for 20 ns;
    addressBus<=x"1237"; wait for 20 ns;

    -- =========================================
    -- Test Case 3: MISS + UPDATE (write full block for 0x12B4)
    -- =========================================
    update<='1';
    wr<='1';
    tagIn<=x"12";

    addressBus<=x"12B4"; dataIn<=x"11"; wait for 10 ns;
    addressBus<=x"12B5"; dataIn<=x"22"; wait for 10 ns;
    addressBus<=x"12B6"; dataIn<=x"33"; wait for 10 ns;
    addressBus<=x"12B7"; dataIn<=x"44"; wait for 10 ns;

    -- disable update/write and go directly to first read address
    update<='0';
    wr<='0';
    addressBus<=x"12B4";
    wait for 30 ns;

    -- =========================================
    -- Test Case 4: HIT reads for 0x12B4 block
    -- =========================================
    addressBus<=x"12B4"; wait for 20 ns;
    addressBus<=x"12B5"; wait for 20 ns;
    addressBus<=x"12B6"; wait for 20 ns;
    addressBus<=x"12B7"; wait for 20 ns;

    -- =========================================
    -- Test Case 5: Re-check first line again (should still HIT)
    -- =========================================
    addressBus<=x"1234";
    wait for 30 ns;

    addressBus<=x"1234"; wait for 20 ns;
    addressBus<=x"1235"; wait for 20 ns;
    addressBus<=x"1236"; wait for 20 ns;
    addressBus<=x"1237"; wait for 20 ns;

    wait;

end process;

end Behavioral;
