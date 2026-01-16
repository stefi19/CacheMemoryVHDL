simulationScenario.vhd — Short README (scenario testbench)

Purpose
- Higher-level scenario testbench for `topLevelModule.vhd` covering read-miss/read-hit and write-miss/write-hit cases.

What it does
- Runs a sequence of operations that exercise read and write hits and misses, verifying the system-level behavior.
- Includes write-allocate and readback checks.

Use
- Useful as a compact integration test for the entire cache system.
