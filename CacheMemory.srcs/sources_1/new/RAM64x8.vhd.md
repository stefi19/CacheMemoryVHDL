RAM64x8.vhd — Short README

Purpose
- 64 x 8-bit synchronous RAM used for data banks.

Entity / Ports
- `wr` (in) — write enable (synchronous).
- `cs` (in) — chip select.
- `index` (in std_logic_vector(5 downto 0)) — 6-bit address (0..63).
- `input` (in std_logic_vector(7 downto 0)) — data to write.
- `clk` (in) — clock.
- `data` (out std_logic_vector(7 downto 0)) — data read out.

Behavior
- Synchronous process on rising edge of `clk`:
  - If `cs='1'` and `wr='1'` then write `input` into memory at `index`.
  - Always drive `data` with memory at `index` (registered read).

Testbenches
- `TB_RAM64x8.vhd` exercises write/read at several addresses.

Notes
- Memory is modelled with a VHDL array; initial contents = 0.
