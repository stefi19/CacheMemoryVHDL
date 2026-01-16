FSM.vhd

Purpose
- Small finite state machine that coordinates cache operations (search, update, rdwr).

Control unit overview
- A control unit is implemented as a finite-state machine (FSM) to coordinate the operations performed by the cache memory. The FSM sequences the steps required to service CPU requests and to interact with the cache data/tag memories and the (simulated) main memory when a miss occurs.

- The high-level roles of the FSM states are:
	- SEARCH: locate the requested data in the cache (compare tag). If the tag comparison fails (a miss), the cache must fetch the appropriate block from main memory.
	- UPDATE: bring an entire block into the cache as a consequence of a miss. While in this state the `updateSignal` output is asserted; the cache writes the provided `tagIn` into the tag memory and loads the block's bytes into the selected data bank entries.
	- RDWR: perform the read or write action for the CPU after the cache line is ready (either because it was already present or after an update). From the cache perspective this means providing the requested data on `dataOut` (for reads) and performing data writes into the bank(s) when `cacheWr` is asserted (for writes).

Note: the FSM controls only the cache control signals (`updateSignal`, `cacheWr`) and relies on the cache module (`cache256`) to perform the actual memory reads/writes and tag updates.

Entity / Ports
- `hit` (in) — result of tag comparison.
- `cpuWr` (in) — CPU write indicator (request to write data into cache).
- `clk` (in) — clock.
- `updateSignal` (out) — asserted in UPDATE state to trigger cache line allocation/update.
- `cacheWr` (out) — asserted in RDWR state when a CPU write should be performed.

States (detailed, explicit behavior)
- SEARCH
	- Purpose: determine whether the requested address is present in the cache (hit) or not (miss).
	- Inputs sampled: `hit` (from tag comparator / tag memory) and `cpuWr` (request type).
	- Behavior:
		- If `hit = '1'` -> the FSM transitions to `RDWR` so the cache can serve the request immediately.
		- If `hit = '0'` -> the FSM transitions to `UPDATE` to fetch and install the missing block from main memory.
		- Outputs: `updateSignal <= '0'`, `cacheWr <= '0'` while in SEARCH.

- UPDATE
	- Purpose: allocate and load the full block into the cache after a miss, and set the tag/valid bit.
	- Behavior:
		- Assert `updateSignal <= '1'` for one clock cycle (or as required by the cache interface) to tell `cache256` to write the `tagIn` into tag memory and write block data into the data banks (the cache handles which bytes/banks are written).
		- After asserting `updateSignal`, move to `RDWR` so the CPU access can be completed.
		- Outputs: `updateSignal = '1'` while in UPDATE; `cacheWr = '0'`.

- RDWR
	- Purpose: perform the final read or write to satisfy the CPU request (the cache line is now valid and present).
	- Behavior:
		- If `cpuWr = '1'` then the FSM asserts `cacheWr <= '1'` during RDWR to perform the write into the selected bank(s).
		- If `cpuWr = '0'` then the cache will present the requested data on `dataOut` (a read). The FSM does not modify data content except via `cacheWr` when writing.
		- After executing the read or write operation, the FSM transitions back to `SEARCH` to await the next CPU request.
		- Outputs: `cacheWr` set according to `cpuWr`; `updateSignal = '0'`.

Usage
- Instantiated by `topLevelModule.vhd` to control the `cache256` module.

Testbenches
- `TB_FSM.vhd` tests state transitions for hit/miss and write conditions.
