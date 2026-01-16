TB_RAM64x9.vhd

Purpose
- Testbench for `RAM64x9.vhd` (tag memory + valid bit).

What it does
- Writes tag values to addresses and verifies that `valid` becomes '1' and `data` reads back the tag.
- Also verifies that writes do not occur when `cs='0'`.

Use
- Ensures the tag memory semantics expected by `cache256` are correct.

Expected steps and outcomes (pași așteptați și rezultate)

1) Write tag 0x12 to address 0 and check valid
   - Stimulus:
     - `wr <= '1'`, `cs <= '1'`, `index = "000000"`, `input = x"12"`.
     - Wait through rising edge.
   - Expected outcomes:
     - `valid` for index 0 becomes 1 and `data` reads back x"12".

2) Ensure write with cs=0 does not update memory
   - Stimulus: `cs <= 0`, `wr <= 1`, `index = "000010"`, `input = x"FF"`.
   - Expected outcomes: memory at index 2 remains unchanged and `valid` remains 0 (unless previously set).

3) Edge addresses test (index 63)
   - Stimulus: write tag x"55" at index "111111" and read back.
   - Expected: `valid` becomes 1 and `data` reads back x"55".

Notes / verification tips
- Monitor `data` and `valid` outputs in the waveform for the addressed indices.
- Add asserts after waits to confirm `data` and `valid` values match expectations.
