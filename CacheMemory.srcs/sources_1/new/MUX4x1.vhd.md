MUX4x1.vhd — Short README

Purpose
- 4-to-1 multiplexer for 8-bit data lines. Chooses one of four data outputs according to a 2-bit selection.

Entity / Ports
- `data0..data3` (in std_logic_vector(7 downto 0)) — inputs.
- `selection` (in std_logic_vector(1 downto 0)) — selects which input to forward.
- `dataOut` (out std_logic_vector(7 downto 0)) — selected output.

Behavior
- Uses `with selection select` to forward the chosen data vector.

Instantiated by
- `cache256.vhd` to select the correct byte from the 4 banks based on `offset`.
