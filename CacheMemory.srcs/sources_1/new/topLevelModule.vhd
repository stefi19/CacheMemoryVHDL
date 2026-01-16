----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 12:37:36 PM
-- Design Name: 
-- Module Name: topLevelModule - Behavioral
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

entity topLevelModule is
  Port ( 
    addressBus: in std_logic_vector(15 downto 0);
    dataIn: in std_logic_vector(7 downto 0);
    cpuWr: in std_logic;
    clk: in std_logic;
    dataOut: out std_logic_vector(7 downto 0)
  );
end topLevelModule;

architecture Behavioral of topLevelModule is

signal hit: std_logic;
signal updateSig: std_logic;
signal wrSig: std_logic;
signal tag: std_logic_vector(7 downto 0);
signal cacheWrSig: std_logic;

component FSM is
  Port ( 
      hit: in STD_LOGIC;
      cpuWr: in STD_LOGIC;
      clk: in STD_LOGIC;
      updateSignal: out STD_LOGIC;
      cacheWr: out STD_LOGIC
  );
end component;

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

tag<=addressBus(15 downto 8);

FSM_u: FSM port map(hit=>hit, cpuWr=>cpuWr, clk=>clk, updateSignal=>updateSig, cacheWr=>cacheWrSig);

Cache_u: cache256 port map(
    addressBus=>addressBus,
    update=>updateSig,
    wr=>cacheWrSig,
    clk=>clk,
    dataIn=>dataIn,
    tagIn=>tag,
    dataOut=>dataOut,
    hitOut=>hit
);
end Behavioral;
