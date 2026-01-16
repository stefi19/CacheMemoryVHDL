decoder2x4.vhd — Short README

Purpose
- 2-to-4 decoder used to convert the 2-bit offset into a 4-bit one-hot selection for the four data banks.

Entity / Ports
- `toDecode` (in std_logic_vector(1 downto 0)) — 2-bit input offset.
- `decoded` (out std_logic_vector(3 downto 0)) — one-hot decoded output.

Behavior
- Uses `with toDecode select` to map "00"->"0001", "01"->"0010", "10"->"0100", "11"->"1000".

Instantiated by
- `cache256.vhd` for bank chip-select generation.

Notes
- Purely combinational; no clock.
