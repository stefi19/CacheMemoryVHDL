----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 11:41:09 AM
-- Design Name: 
-- Module Name: MUX4x1 - Behavioral
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

entity MUX4x1 is
  Port (
    data0, data1, data2, data3: in std_logic_vector(7 downto 0);
    selection: in std_logic_vector(1 downto 0);
    dataOut: out std_logic_vector(7 downto 0)
   );
end MUX4x1;

architecture Behavioral of MUX4x1 is

begin
with selection select dataout<=
    data0 when "00",
    data1 when "01",
    data2 when "10",
    data3 when others;

end Behavioral;
