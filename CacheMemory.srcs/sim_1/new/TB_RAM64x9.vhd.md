TB_RAM64x9.vhd — Short README (testbench)

Purpose
- Testbench for `RAM64x9.vhd` (tag memory + valid bit).

What it does
- Writes tag values to addresses and verifies that `valid` becomes '1' and `data` reads back the tag.
- Also verifies that writes do not occur when `cs='0'`.

Use
- Ensures the tag memory semantics expected by `cache256` are correct.
