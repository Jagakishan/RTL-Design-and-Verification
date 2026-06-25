# RTL DESIGN AND VERIFICATION SERIES

## 1. UART

### Design

- UART TX and RX RTL implementation in SystemVerilog
- Baud Rate Generator for 9600 baud operation from a 50 MHz system clock. Can be tweaked for any Baud Rate
- 16× oversampling and mid-bit sampling for robust data recovery at the receiver
- Loopback state-machine configuration used for end-to-end data transfer

### Verification

- Transaction, Generator, Driver, Monitor, and Scoreboard architecture
- Mailbox-based communication between verification components
- Event-based synchronization between Generator and Driver
- Interface-based DUT connectivity using virtual interfaces
- Scoreboard with multiple mailboxes to check control and data signals for integrity verification

### Results

- Random-cyclic stimulus generation covering all 256 possible 8-bit data values
- 256/256 transactions passed successfully with zero mismatches
- Reset injected transactions provided same positive results. 

---

## 2. SPI 

### Design

- SPI Mode-0 communication (CPOL=0, CPHA=0). Tweakable for other 3 modes as well
- 8-bit full-duplex data transfer
- Master-generated serial clock and chip-select control
- Independent transmit and receive shift-register logic in both Master and Slave

### Verification

- OOPs-based SystemVerilog verification environment
- Similar Generator, Driver, Monitor, and Scoreboard architecture
- Constrained-random stimulus with reset injection and inter-transaction gap testing
- Exhaustive validation of all 256 possible data values in both directions
- Automated scoreboard checking for Master->Slave and Slave->Master data integrity

### Results

- All randomized and directed test scenarios passed successfully
- 100% scoreboard match between expected and actual transactions
- Verified correct operation across data, reset, and timing corner cases

---

# 3. Synchronous FIFO

### Design

- Implemented circular buffer architecture with configurable depth and data width
- Used extended read/write pointers (extra MSB) for easy full and empty detection
- Supports simultaneous read and write operations, along with overflow and underflow indication

### Verification

- Built similar verification environment to previous project, with even more randomization variables
- Implemented dynamic queue-based reference model to verify FIFO ordering and data integrity
- Verified normal operation, pointer wraparound, simultaneous read/write, overflow, underflow, and reset scenarios using constrained-random testing

### Results

- Executed 1000+ randomized transactions with zero data mismatches and Coverages are recorded.

---

## 4. Asynchronous FIFO

### Design

- Implemented an Asynchronous FIFO for reliable data transfer between independent write and read clock domains
- The design uses Gray-coded read/write pointers to avoid metastability in two-stage flop synchronizers for CDC handling
- Full/empty flag generation based on domain synchronized pointer comparisons
- Flags are robust in a way that they may assert full or empty for 2 aditional clock cycles, but never miss to assert flags when FIFO is really full/empty
- The 2 cycle latency is for synchronisation which is acceptable in CDC scenario

### Verification

- A self-checking SystemVerilog testbench similar to previous projects in the series
- Verification was performed using a reference queue model just like synch-FIFO
- Additional mailbox from the driver to make sure the scoreboard uses queue only when required
- Constrained-random stimulus, and stress testing across multiple clock ratios, overflow/underflow scenarios, and simultaneous read/write operations.

### Results

- Executed 1000+ randomized transactions with zero data mismatches and Coverages are recorded.

---

# Author

Jagakishan SK
