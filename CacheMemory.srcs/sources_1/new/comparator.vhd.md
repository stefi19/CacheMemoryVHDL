comparator.vhd — Short README

Purpose
- Simple 8-bit comparator used to compare a requested tag with the stored tag from tag memory.

Entity / Ports
- `tag` (in std_logic_vector(7 downto 0)) — requested tag (from addressBus).
- `tagMem` (in std_logic_vector(7 downto 0)) — tag value read from tag memory.
- `hit` (out std_logic) — asserted '1' when `tag = tagMem` else '0'.

Behavior
- Combinational equality check: `hit <= '1' when tag = tagMem else '0'`.

Instantiated by
- `cache256.vhd` to determine a tag match.

Testbenches / usage
- Exercised indirectly via `TB_cache.vhd` and `TB_cacheSystem.vhd`.
