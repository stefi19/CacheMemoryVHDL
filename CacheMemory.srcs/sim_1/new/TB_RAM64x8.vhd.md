TB_RAM64x8.vhd — Short README (testbench)

Purpose
- Testbench for `RAM64x8.vhd` to verify synchronous writes and reads.

What it does
- Writes known 8-bit patterns to addresses 0,1 and 63.
- Then reads them back to confirm memory behavior.

Use
- Good to sanity check the data banks used by `cache256`.
