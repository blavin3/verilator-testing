# verilator-testing
Testing Verilator

## 1 Install Verilator and GTKWave

``` sudo apt install verilator ```

``` sudo apt install gtkwave ```

## 2 Example Worrkflow

### 2.1 Convert Verilog to C++

``` cd dflop ```

``` verilator --cc dflop.sv```

### 2.2 Verilate the Testbench and Build the Simulation Executable

``` verilator -Wall --trace -cc dflop.sv --exe tb_dflop.cpp ```

``` make -C obj_dir -f Vdflop.mk Vdflop ```

### 2.3 Run the Testbanch

``` ./obj_dir/Vdflop ```

### 2.4 View the Verilator Waveform

``` gtkwave waveform.vcd ```