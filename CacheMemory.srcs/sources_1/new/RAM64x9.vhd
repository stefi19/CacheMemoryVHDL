----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 11:28:56 AM
-- Design Name: 
-- Module Name: RAM64x9 - Behavioral
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

entity RAM64x9 is
  Port ( 
    wr: in std_logic;
    cs: in std_logic;
    index: in std_logic_vector(5 downto 0);
    input: in std_logic_vector(7 downto 0);
    clk: in std_logic;
    data: out std_logic_vector(7 downto 0);
    valid: out std_logic
  );
end RAM64x9;

architecture Behavioral of RAM64x9 is
type mem is array (0 to 63) of std_logic_vector(8 downto 0);
signal memory: mem:=(others=>(others=>'0'));
begin
process(clk)
begin
    if(rising_edge(clk)) then
        if(cs='1') then
            if(wr='1') then
                memory(to_integer(unsigned(index)))(7 downto 0)<=input;
                memory(to_integer(unsigned(index)))(8)<='1';
            end if;
         end if;
         data<=memory(to_integer(unsigned(index)))(7 downto 0);
         valid<=memory(to_integer(unsigned(index)))(8);
    end if;
end process;

end Behavioral;
