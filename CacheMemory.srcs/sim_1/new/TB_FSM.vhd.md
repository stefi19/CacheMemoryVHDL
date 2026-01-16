TB_FSM.vhd — Short README (testbench)

Purpose
- Testbench for the `FSM.vhd` module. Verifies state transitions and asserted outputs.

What it does
- Drives `hit` input and observes `updateSignal` and `wr`/`cacheWr` outputs.
- Checks SEARCH -> UPDATE -> RDWR flow and behavior when `hit` toggles.

Use
- Run to visually inspect FSM outputs and ensure correct timing relative to `clk`.

Expected steps and outcomes (pași așteptați și rezultate)

1) Test SEARCH -> UPDATE -> RDWR transition when hit='0'
   - Stimulus:
     - Drive `hit <= '0'` for several clock cycles.
   - Expected outcomes:
     - FSM should leave SEARCH and assert `updateSignal = '1'` (UPDATE state) on the next clock.
     - After UPDATE, FSM should progress to RDWR and then back to SEARCH.
     - `cacheWr` remains '0' because `cpuWr` is not asserted.

2) Test RDWR behavior when hit='1' and cpuWr='1'
   - Stimulus:
     - Drive `hit <= '1'` and `cpuWr <= '1'` for a cycle.
   - Expected outcomes:
     - From SEARCH the FSM should go to RDWR.
     - During RDWR, `cacheWr` (or `wr` output) should be asserted when `cpuWr = '1'` to indicate a write operation.
     - After the RDWR cycle the FSM returns to SEARCH.

3) Multiple toggles / stability
   - Stimulus: toggle `hit` between '0' and '1' across multiple clock cycles.
   - Expected outcomes: FSM responds deterministically to `hit` and `cpuWr` inputs, producing `updateSignal` and `cacheWr` only in the states described above.

Notes
- Monitor these signals in the waveform: `hit`, `cpuWr`, `updateSignal`, `cacheWr`, and `clk`.
- For automated checks, add `assert` statements in the testbench that check the asserted outputs after each rising-edge of `clk` according to the expected state.
