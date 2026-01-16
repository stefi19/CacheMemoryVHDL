----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 11:47:49 AM
-- Design Name: 
-- Module Name: cache256 - Behavioral
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

entity cache256 is
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
end cache256;

architecture Behavioral of cache256 is

signal tag: std_logic_vector(7 downto 0);
signal index: std_logic_vector(5 downto 0);
signal offset: std_logic_vector(1 downto 0);
signal chosenData: std_logic_vector(7 downto 0);
signal isValid: std_logic;
signal valid: std_logic;
signal hit: std_logic;
signal data0,data1,data2,data3: std_logic_vector(7 downto 0);
signal tagMemory: std_logic_vector(7 downto 0);
signal tagData: std_logic_vector(7 downto 0);
signal memChoose:std_logic_vector(3 downto 0);
signal cs: std_logic_vector(3 downto 0);

component comparator is
  Port ( 
       tag: in std_logic_vector(7 downto 0);
       tagMem: in std_logic_vector(7 downto 0);
       hit: out std_logic
  );
end component;
component decoder2x4 is
  Port ( 
    toDecode: in std_logic_vector(1 downto 0);
    decoded: out std_logic_vector(3 downto 0)
  );
end component;
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
component MUX4x1 is
  Port (
    data0, data1, data2, data3: in std_logic_vector(7 downto 0);
    selection: in std_logic_vector(1 downto 0);
    dataOut: out std_logic_vector(7 downto 0)
   );
end component;

begin

tag <= addressBus(15 downto 8);
index <= addressBus(7 downto 2);
offset <= addressBus(1 downto 0);

decode: decoder2x4 port map (toDecode => offset, decoded => memChoose);
cs(0) <= (update or wr) and memChoose(0);
cs(1) <= (update or wr) and memChoose(1);
cs(2) <= (update or wr) and memChoose(2);
cs(3) <= (update or wr) and memChoose(3);

mem0: RAM64x8 port map (wr=> (update or wr), cs=>cs(0), index=>index, input=>dataIn, clk=>clk, data=>data0);
mem1: RAM64x8 port map (wr=> (update or wr), cs=>cs(1), index=>index, input=>dataIn, clk=>clk, data=>data1);
mem2: RAM64x8 port map (wr=> (update or wr), cs=>cs(2), index=>index, input=>dataIn, clk=>clk, data=>data2);
mem3: RAM64x8 port map (wr=> (update or wr), cs=>cs(3), index=>index, input=>dataIn, clk=>clk, data=>data3);
tagMem: RAM64x9 port map(
    wr=>update,
    cs=>'1',
    index=>index,
    input=>tagIn,
    clk=>clk,
    data=>tagMemory,
    valid=>valid
);

muxout: MUX4x1 port map (data0=>data0, data1=>data1, data2=>data2, data3=>data3, selection=>offset, dataOut=>chosenData);

comparing: comparator port map (tag=>tag, tagMem=>tagMemory, hit=>hit);

isValid<=hit and valid;
hitOut<=hit and valid;
with isValid select dataOut <=
    chosenData when '1',
    (others=>'Z') when others;

end Behavioral;
