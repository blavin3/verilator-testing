#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "obj_dir/Vdflop.h"

#define MAX_SIM_TIME 20
vluint64_t sim_time = 0;

int main(int argc, char** argv, char** env) {
    Vdflop *dut = new Vdflop;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    dut->reset = 0;

    while (sim_time < MAX_SIM_TIME) {
        dut->clk ^= 1;
        switch(sim_time)
        {
            case 0:
                dut->in_1 = 0;
            break;  

            case 6:
                dut->reset = 1;
            break;  

            case 13:
                dut->in_1 = 0;
            break;

            default:
                dut->in_1 = 1;
                dut->reset = 0;
            break;            
        }
        dut->eval();
        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
