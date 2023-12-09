# verilator-testing
Testing Verilator

## 1 Install Verilator and GTKWave

``` sudo apt install verilator ```

``` sudo apt install gtkwave ```

## 2 Example Worrkflow

### 2.1 Convert Verilog to C++

``` cd alu/ ```

``` verilator --cc alu.sv```

### 2.2 Verilate the Testbench and Build the Simulation Executable

``` verilator -Wall --trace -cc alu.sv --exe tb_alu.cpp ```

``` make -C obj_dir -f Valu.mk Valu ```

### 2.3 Run the Testbanch

``` /obj_dir/Valu ```

### 2.4 View the Verilator Waveform

``` gtkwave waveform.vcd ```