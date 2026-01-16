simulationScenario.vhd

Expected steps and outcomes

1) RD MISS (first read on empty cache)
	 - Stimulus:
		 - `cpuWr = '0'`, `addressBus = x"1234"`, `dataIn = x"00"`
		 - Wait time in testbench: 60 ns (allow FSM -> UPDATE -> RDWR sequence)
	 - Expected behavior/outcomes:
		 - Before the update: `hitOut` should be '0' (miss).
		 - FSM will transition SEARCH -> UPDATE (so `updateSignal` will assert for the update cycle).
		 - The cache will install the block for address x"1234" (tag written, valid bit set).
		 - After update completes, reading the same address should return the loaded byte. Because the testbench provides `dataIn = x"00"` during update, `dataOut` for x"1234" is expected to be x"00" (and `hitOut` becomes '1').

2) RD HIT (read same address again)
	 - Stimulus:
		 - `cpuWr = '0'`, `addressBus = x"1234"`
		 - Wait time in testbench: 40 ns
	 - Expected outcomes:
		 - `hitOut` should be '1' (cache hit).
		 - `dataOut` should be the value loaded earlier (x"00").

3) WR HIT (write into same cached line)
	 - Stimulus:
		 - `cpuWr = '1'`, `addressBus = x"1234"`, `dataIn = x"99"`
		 - Wait time in testbench: 60 ns (allow RDWR to assert write)
	 - Expected outcomes:
		 - Since the line is cached, `hitOut` is '1' at SEARCH and FSM goes to RDWR.
		 - FSM sets `cacheWr` during RDWR when `cpuWr = '1'` so the cache writes `dataIn` (x"99") into the correct bank/offset.
		 - After the write, a subsequent read should return x"99".

4) WR MISS (write to a new address -> miss -> allocate + write)
	 - Stimulus:
		 - `cpuWr = '1'`, `addressBus = x"12B4"`, `dataIn = x"55"`
		 - Wait time in testbench: 60 ns
	 - Expected outcomes:
		 - Initial `hitOut` for address x"12B4" is '0' (miss).
		 - FSM transitions SEARCH -> UPDATE: `updateSignal` asserted to allocate the new block and set tag/valid.
		 - After allocation, FSM proceeds to RDWR and `cacheWr` is asserted (because `cpuWr = '1'`), so the write of x"55" is performed into the newly allocated line.
		 - A following read to x"12B4" should now be a HIT and return x"55".

5) RD HIT on first line again
	 - Stimulus:
		 - `cpuWr = '0'`, `addressBus = x"1234"`
		 - Wait time in testbench: 40 ns
	 - Expected outcomes:
		 - The line at x"1234" should still be valid and `hitOut` should be '1'.
		 - `dataOut` should return the value written earlier (x"99").

Notes / verification tips
- Observe these signals in simulation waveforms: `hitOut`, `dataOut`, `updateSignal` (from FSM), and `cacheWr` (from FSM). Also inspect tag memory valid bits if you instrument `RAM64x9`.
- Timing: the testbench uses waits (60 ns / 40 ns) to give the FSM and cache modules time to progress through SEARCH -> UPDATE -> RDWR; adjust or instrument if you change FSM timing.
- If you want automated checks, consider adding `assert` statements in the testbench after each wait to fail the simulation on mismatched `dataOut`/`hitOut` values.

