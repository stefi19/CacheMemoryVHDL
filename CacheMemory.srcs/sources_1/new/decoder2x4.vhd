----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 11:16:39 AM
-- Design Name: 
-- Module Name: decoder2x4 - Behavioral
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

entity decoder2x4 is
  Port ( 
    toDecode: in std_logic_vector(1 downto 0);
    decoded: out std_logic_vector(3 downto 0)
  );
end decoder2x4;

architecture Behavioral of decoder2x4 is

begin
with toDecode select decoded <=
    "0001" when "00",
    "0010" when "01",
    "0100" when "10",
    "1000" when "11",
    "0000" when others;

end Behavioral;
