----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 06:30:00 PM
-- Design Name: 
-- Module Name: TB_topScenario - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Scenario TB for topLevelModule (RD hit/miss + WR hit/miss)
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

entity simulationScenario is
end simulationScenario;

architecture Behavioral of simulationScenario is

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
    -- =========================================================
    -- 1) RD MISS  (first read on empty cache)
    -- =========================================================
    cpuWr<='0';
    addressBus<=x"1234";
    dataIn<=x"00";
    wait for 60 ns;

    -- =========================================================
    -- 2) RD HIT   (read same address again -> should output value)
    -- =========================================================
    cpuWr<='0';
    addressBus<=x"1234";
    wait for 40 ns;

    -- =========================================================
    -- 3) WR HIT   (write into same cached line)
    -- =========================================================
    cpuWr<='1';
    addressBus<=x"1234";
    dataIn<=x"99";
    wait for 60 ns;

    -- verify write hit
    cpuWr<='0';
    addressBus<=x"1234";
    wait for 40 ns;

    -- =========================================================
    -- 4) WR MISS  (write to a new address -> miss -> allocate + write)
    -- =========================================================
    cpuWr<='1';
    addressBus<=x"12B4";
    dataIn<=x"55";
    wait for 60 ns;

    -- verify write miss result (should now be hit and output 55)
    cpuWr<='0';
    addressBus<=x"12B4";
    wait for 40 ns;

    -- =========================================================
    -- 5) RD HIT on first line again (should still output 99)
    -- =========================================================
    cpuWr<='0';
    addressBus<=x"1234";
    wait for 40 ns;

    wait;

end process;

end Behavioral;
