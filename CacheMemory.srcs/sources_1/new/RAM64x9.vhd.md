RAM64x9.vhd — Short README

Purpose
- 64 x 9-bit synchronous RAM used for tag storage (8-bit tag + 1-bit valid flag).

Entity / Ports
- `wr` (in), `cs` (in), `index` (in 6 bits), `input` (in 8 bits — tag), `clk` (in)
- `data` (out 8 bits) — tag value read out.
- `valid` (out) — valid bit for the addressed entry.

Behavior
- On rising edge of `clk`, when `cs='1'` and `wr='1'` the memory entry at `index` is updated:
  - bits [7:0] <= `input` (tag)
  - bit [8] <= '1' (set valid)
- Always outputs `data` and `valid` for the requested `index`.

Testbenches
- `TB_RAM64x9.vhd` writes tag values and checks `valid` and read data.

Notes
- Valid bit is set on write; currently there is no explicit invalidation logic.
