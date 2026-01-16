----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 12:48:39 PM
-- Design Name: 
-- Module Name: TB_RAM64x8 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_RAM64x8 is
end TB_RAM64x8;

architecture Behavioral of TB_RAM64x8 is

signal wr: std_logic:='0';
signal cs: std_logic:='0';
signal index: std_logic_vector(5 downto 0):=(others=>'0');
signal input: std_logic_vector(7 downto 0):=(others=>'0');
signal clk: std_logic:='0';
signal data: std_logic_vector(7 downto 0);

component RAM64x8 is
  Port ( 
    wr: in std_logic;
    cs: in std_logic;
    index: in std_logic_vector(5 downto 0);
    input: in std_logic_vector(7 downto 0);
    clk: in std_logic;
    data: out std_logic_vector(7 downto 0)
  );
end component;
begin
uut: RAM64x8 port map (wr=>wr, cs=>cs, index=>index, input=>input, clk=>clk, data=>data);
clkProcess: process
begin
    clk<='0';
    wait for 5 ns;
    clk<='1';
    wait for 5 ns;
end process;

stimulusProcess: process
begin
    --write 0xAA to address 0
    cs<='0';
    wr<='1';
    index<="000000";
    input<="10101010";
    wait for 30ns;
    cs<='1';
    wait for 10ns;
    
    --read from address 0
    wr<='0';
    cs<='1';
    wait for 10ns;
    
    --write 0xF0 to address 1
    wr<='1';
    cs<='1';
    index<="000001";
    input<="11110000";
    wait for 10ns;
    
    --read from address 1
    wr<='0';
    cs<='1';
    wait for 10ns;
    
    --write 0x0F to address 63
    wr<='1';
    cs<='1';
    index<="111111";
    input<="00001111";
    wait for 10ns;
    
    --read from address 63
    wr<='0';
    cs<='1';
    wait for 10 ns;
    
    wait;
    
end process;

end Behavioral;
