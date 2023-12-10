#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "obj_dir/Vstate_machine.h"

#define MAX_SIM_TIME 30
vluint64_t sim_time = 0;

int main(int argc, char** argv, char** env) {
    Vstate_machine *dut = new Vstate_machine;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    dut->reset = 0;

    while (sim_time < MAX_SIM_TIME) {
        dut->clk ^= 1;
        switch(sim_time)
        {
            case 22:
                dut->kill = 1;
            break;

            default:
                dut->go = 1;
                dut->reset = 0;
                dut->kill = 0;
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
