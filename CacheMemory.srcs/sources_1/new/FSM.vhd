----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/15/2026 06:48:41 PM
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
  Port ( 
      hit: in STD_LOGIC;
      cpuWr: in STD_LOGIC;
      clk: in STD_LOGIC;
      updateSignal: out STD_LOGIC;
      cacheWr: out STD_LOGIC
  );
end FSM;

architecture Behavioral of FSM is
    type s is (SEARCH,UPDATE,RDWR);
    signal state: s:=SEARCH;
begin
    process (clk)
    begin
        if(rising_edge(clk)) then
            updateSignal<='0';
            cacheWr<='0';

            case state is  
                when SEARCH =>
                    if (hit='1') then
                        state <= RDWR;
                    else
                        state <= UPDATE;
                    end if;

                when UPDATE =>
                    updateSignal <= '1';
                    state <= RDWR;

                when RDWR =>
                    if(cpuWr='1') then
                        cacheWr <= '1';
                    end if;
                    state <= SEARCH;

            end case;
         end if;
    end process;
end Behavioral;

