TB_RAM64x8.vhd — Short README (testbench)

Purpose
- Testbench for `RAM64x8.vhd` to verify synchronous writes and reads.

What it does
- Writes known 8-bit patterns to addresses 0,1 and 63.
- Then reads them back to confirm memory behavior.

Use
- Good to sanity check the data banks used by `cache256`.

Expected steps and outcomes (pași așteptați și rezultate)

1) Write 0xAA to address 0 (write then read)
   - Stimulus:
     - `wr <= '1'`, `cs <= '1'`, `index = "000000"`, `input = "10101010"` as in TB.
     - Wait 30 ns then enable cs to store the value.
   - Expected outcomes:
     - Memory location 0 should contain 0xAA after the write.
     - Reading index 0 with `wr = 0` and `cs = 1` should produce data = "10101010".

2) Write 0xF0 to address 1 and read back
   - Stimulus: write index "000001" with input "11110000" then read.
   - Expected: memory[1] = 0xF0, read returns 0xF0.

3) Write 0x0F to address 63 and read back
   - Stimulus: write index "111111" with input "00001111" then read.
   - Expected: memory[63] = 0x0F, read returns 0x0F.

Notes / verification tips
- Monitor `memory` read outputs (`data`) and verify after clock edges.
- Add asserts in the TB after read waits to fail simulation on mismatch.
