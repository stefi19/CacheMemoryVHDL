TB_cache.vhd — Short README (testbench)

Purpose

What it does

Signals observed

Use

Expected steps and outcomes (pași așteptați și rezultate)

This testbench focuses on block-level update (write-allocate) and subsequent read hits. The TB sequences multiple operations; below each step is the stimulus and the expected outcome.

1) MISS + UPDATE for block starting at address x"1234"
	 - Stimulus (from TB):
		 - `update <= '1'`, `wr <= '1'`, `tagIn <= x"12"`.
		 - `addressBus` sequences: x"1234" (dataIn x"AA"), x"1235" (x"BB"), x"1236" (x"CC"), x"1237" (x"DD").
	 - Expected outcomes:
		 - During UPDATE the cache should write the provided `tagIn` into tag memory for the indexed lines and write the four bytes into the four bank entries.
		 - After the UPDATE finishes, the tag entries for the affected indices should have `valid = '1'` and tag = x"12".

2) READ from the first block entry (x"1234") — expect HIT after update
	 - Stimulus:
		 - `update <= '0'`, `wr <= '0'`, `addressBus <= x"1234"`.
		 - TB waits to allow SEARCH -> (already updated) -> RDWR/READ.
	 - Expected outcomes:
		 - `hitOut` should be '1'.
		 - `dataOut` should equal x"AA" (the value written into x"1234" during update).

3) READ the remaining bytes of the block (x"1235", x"1236", x"1237") — expect HITs
	 - Stimulus:
		 - TB steps `addressBus` to x"1235", x"1236", x"1237" with small waits between.
	 - Expected outcomes:
		 - For each address: `hitOut = '1'` and `dataOut` returns the corresponding bytes x"BB", x"CC", x"DD".

4) MISS + UPDATE for another block (x"12B4")
	 - Stimulus:
		 - `update <= '1'`, `wr <= '1'`, `tagIn <= x"12"` and `addressBus` = x"12B4"..x"12B7" with data bytes x"11", x"22", x"33", x"44".
	 - Expected outcomes:
		 - New block's tag entries become valid with tag x"12" and data bytes are stored in the data banks for the appropriate indices.

5) READ back second block -> expect HITs
	 - Stimulus: read x"12B4"..x"12B7" after update sequence.
	 - Expected outcomes: `hitOut = '1'` and `dataOut` equals x"11", x"22", x"33", x"44" respectively.

Notes / verification tips
- Signals to watch in waveform: `update`, `wr`, `tagIn`, `dataIn`, `dataOut`, and `hitOut`. If desired, monitor the tag memory `valid` outputs (from `RAM64x9`) to confirm valid-bit changes.
- The TB uses `update or wr` logic to perform writes; verify that chip-select (`cs`) logic and decoder outputs correspond to the addressed offset.
- Consider adding `assert` checks in the testbench after each read to fail the simulation automatically on mismatch (recommended for automated verification).
