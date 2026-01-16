----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 01:35:00 PM
-- Design Name: 
-- Module Name: TB_RAM64x9 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench for RAM64x9 (Tag Memory + Valid bit)
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_RAM64x9 is
end TB_RAM64x9;

architecture Behavioral of TB_RAM64x9 is

signal wr: std_logic:='0';
signal cs: std_logic:='0';
signal index: std_logic_vector(5 downto 0):=(others=>'0');
signal input: std_logic_vector(7 downto 0):=(others=>'0');
signal clk: std_logic:='0';
signal data: std_logic_vector(7 downto 0);
signal valid: std_logic;

component RAM64x9 is
  Port ( 
    wr: in std_logic;
    cs: in std_logic;
    index: in std_logic_vector(5 downto 0);
    input: in std_logic_vector(7 downto 0);
    clk: in std_logic;
    data: out std_logic_vector(7 downto 0);
    valid: out std_logic
  );
end component;

begin

uut: RAM64x9 port map (wr=>wr, cs=>cs, index=>index, input=>input, clk=>clk, data=>data, valid=>valid);

clkProcess: process
begin
    clk<='0';
    wait for 5 ns;
    clk<='1';
    wait for 5 ns;
end process;

stimulusProcess: process
begin
    --initial state (cs=0, nothing happens)
    cs<='0';
    wr<='0';
    index<="000000";
    input<=x"00";
    wait for 20 ns;
    
    --write tag 0x12 to address 0 (valid should become 1)
    cs<='1';
    wr<='1';
    index<="000000";
    input<=x"12";
    wait for 10 ns;
    
    --read from address 0 (valid should be 1, data should be 0x12)
    wr<='0';
    cs<='1';
    wait for 10 ns;
    
    --write tag 0xAB to address 1 (valid should become 1)
    wr<='1';
    cs<='1';
    index<="000001";
    input<=x"AB";
    wait for 10 ns;
    
    --read from address 1 (valid should be 1, data should be 0xAB)
    wr<='0';
    cs<='1';
    wait for 10 ns;
    
    --disable cs and try to write (should NOT update memory)
    cs<='0';
    wr<='1';
    index<="000010";
    input<=x"FF";
    wait for 10 ns;
    
    --enable cs and read from address 2 (should still be 0, valid 0)
    cs<='1';
    wr<='0';
    wait for 10 ns;
    
    --write tag 0x55 to address 63 (valid should become 1)
    wr<='1';
    cs<='1';
    index<="111111";
    input<=x"55";
    wait for 10 ns;
    
    --read from address 63 (valid should be 1, data should be 0x55)
    wr<='0';
    cs<='1';
    wait for 10 ns;
    
    wait;
    
end process;

end Behavioral;
