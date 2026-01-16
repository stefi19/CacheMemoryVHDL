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
