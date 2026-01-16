TB_FSM.vhd — Short README (testbench)

Purpose
- Testbench for the `FSM.vhd` module. Verifies state transitions and asserted outputs.

What it does
- Drives `hit` input and observes `updateSignal` and `wr`/`cacheWr` outputs.
- Checks SEARCH -> UPDATE -> RDWR flow and behavior when `hit` toggles.

Use
- Run to visually inspect FSM outputs and ensure correct timing relative to `clk`.
