TB_cacheSystem.vhd — Short README (testbench)

Purpose
- Testbench for `topLevelModule.vhd` demonstrating MISS->UPDATE then HIT behavior seen by a CPU.

What it does
- Drives `addressBus`, `dataIn`, `cpuWr` and tests sequences:
  - Access address -> MISS, update with a block of data.
  - Access same address again -> HIT and correct `dataOut`.
  - Access other addresses to repeat miss/hit patterns.

Use
- Useful to verify integration of `FSM` + `cache256` including timing interactions.

Expected steps and outcomes (pași așteptați și rezultate)

1) Access first address (x"1234") - RD MISS then UPDATE
   - Stimulus:
     - `cpuWr = '0'`, `addressBus = x"1234"`, `dataIn` set by TB as needed.
     - Waits in TB allow the FSM to progress: SEARCH -> UPDATE -> RDWR.
   - Expected outcomes:
     - Initial `hitOut` = '0' (miss).
     - FSM asserts `updateSignal` and `cache256` installs the block (tag written, valid bit set).
     - After update, reading x"1234" should yield `dataOut` equal to the installed value and `hitOut` = '1'.

2) Access same address again - RD HIT
   - Stimulus: `cpuWr = '0'`, `addressBus = x"1234"` (no dataIn needed).
   - Expected outcomes: `hitOut = '1'` and `dataOut` equals previously loaded value.

3) Access other address (example x"12B4") - RD MISS then UPDATE
   - Stimulus: `cpuWr = '0'`, `addressBus = x"12B4"`, `dataIn` as TB specifies.
   - Expected outcomes: similar to step 1 for the new address; `updateSignal` triggers, new block becomes valid and readback returns the installed value.

Notes
- Watch these signals in the waveform: `addressBus`, `cpuWr`, `dataIn`, `dataOut`, `hit`/`hitOut`, and `updateSignal` from the FSM. These reveal the miss->update->hit flow and timing interactions between FSM and cache.
- For automatic verification, add `assert` statements after the waits to check `hit` and `dataOut` values.
