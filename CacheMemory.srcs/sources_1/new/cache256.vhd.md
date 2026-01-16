cache256.vhd

Purpose
- Top-level cache module for a small direct-mapped (4-way per-line) cache design. Manages tags, data banks, valid bits and read/write/update control.

cache capacity: 256 bytes
block size: 4 bytes
number of cache lines: 64
mapping policy: direct-mapped
write policy: write through

```markdown
cache256.vhd

Purpose
- Top-level cache module for a small direct-mapped (4-way per-line) cache design. Manages tags, data banks, valid bits and read/write/update control.

cache capacity: 256 bytes
block size: 4 bytes
number of cache lines: 64
mapping policy: direct-mapped
write policy: write through

Entity / Ports
- `addressBus` (15 downto 0) — CPU address input (tag/index/offset encoded).
- `update` (in) — signal (from FSM) to trigger block update (allocate/load).
- `wr` (in) — write enable (from FSM) for writes to data banks.
- `clk` (in) — synchronous clock.
- `dataIn` (7 downto 0) — data to write into cache data banks.
- `tagIn` (7 downto 0) — tag to write into tag memory.
- `dataOut` (out) — selected read data (Z when miss/invalid).
- `hitOut` (out) — indicates a valid tag match.

Behavior (high level)
- Splits `addressBus` into `tag` (bits 15..8), `index` (bits 7..2) and `offset` (bits 1..0).
- Uses `decoder2x4` on `offset` to select one of four data banks.
- Writes to data banks when `update or wr` and the selected bank's `cs` is asserted.
- Reads data from the selected bank via `MUX4x1` and outputs it if `hit` and `valid` are asserted.
- Tag memory is a separate `RAM64x9` (tag + valid bit).

Instantiated components
- `comparator` (tag compare)
- `decoder2x4` (choose bank from offset)
- `RAM64x8` (4 instances — 4 data banks)
- `RAM64x9` (1 instance — tag + valid bit memory)
- `MUX4x1` (select read byte among banks)

Testbenches / usage
- Tested by `TB_cache.vhd` and indirectly by `TB_cacheSystem.vhd` / `simulationScenario.vhd` via `topLevelModule`.


Formulas for tag / index / offset
- Bit-slice form (as implemented in `cache256.vhd`):
	- tag  <= addressBus(15 downto 8)   -- top 8 bits
	- index <= addressBus(7 downto 2)   -- next 6 bits (selects 64 cache lines)
	- offset <= addressBus(1 downto 0)  -- lower 2 bits (selects byte within 4-byte block)

- Arithmetic form (for a 16-bit address A):
	- tag   = floor(A / 2^8) mod 2^8      -- equals the 8-bit value in bits [15:8]
	- index = floor(A / 2^2) mod 2^6      -- equals the 6-bit value in bits [7:2]
	- offset= A mod 2^2                    -- equals the 2-bit value in bits [1:0]

Notes
- With a cache capacity of 256 bytes and a block size of 4 bytes, there are 64 cache lines (256 / 4 = 64). The 6-bit `index` therefore addresses 0..63.
- The `offset` width of 2 bits selects one of the four bytes inside a block.
- The `tag` width (8 bits) is the remaining high-order bits used for tag comparison.

```

