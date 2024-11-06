import random

import cocotb    
from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.runner import get_runner
from cocotb.triggers import RisingEdge
from cocotb.types import LogicArray

@cocotb.test()
async def day1_mux_test(dut):

    dut.a_i.value = 2
    dut.b_i.value = 4
    for cycle in range (10):
        dut.sel_i.value = 0
        await Timer(1, units="ns")
        dut._log.info("output is %s", dut.y_o.value)
        dut.sel_i.value = 1
        await Timer(1, units="ns")        
        dut._log.info("output is %s", dut.y_o.value)
        assert dut.y_o.value == 2, "output is not 2!"

@cocotb.test()
async def day2_dflipflops_test(dut):

    initial = (
        LogicArray(0)
        if cocotb.SIM_NAME.lower().startswith("verilator")
        else LogicArray("X")
    )
    assert LogicArray(dut.q_norst_o.value) == initial
    assert LogicArray(dut.q_syncrst_o.value) == initial
    assert LogicArray(dut.q_asyncrst_o.value) == initial

    # Set initial input value to prevent it from floating
    dut.d_i.value = 0
    dut.reset.value = 0

    clock = Clock(dut.clk, 10, units="us")  # Create a 10us period clock on port clk
    # Start the clock. Start it low to avoid issues on the first RisingEdge
    cocotb.start_soon(clock.start(start_high=False))
    
    # Synchronize with the clock. This will regisiter the initial `d` value
    await RisingEdge(dut.clk)
    expected_val = 0  # Matches initial input value
    for i in range(10):
        val = random.randint(0, 1)
        dut.d_i.value = val  # Assign the random value val to the input port d
        # 1) Test no reset
        await RisingEdge(dut.clk)
        assert dut.q_norst_o.value == expected_val, f"No-reset is not {expected_val} at cycle {i}!"
        assert dut.q_syncrst_o.value == expected_val, f"Synchronous is not {expected_val} at cycle {i}!"
        assert dut.q_asyncrst_o.value == expected_val, f"Asynchrousou is not {expected_val} at cycle {i}!"
        expected_val = val  # Save random value for next RisingEdge

        # 2) Test reset
        await RisingEdge(dut.clk)
        await Timer(2, units="us")
        dut.reset.value = 1
        await Timer(500, units="ns")
        assert dut.q_norst_o.value == expected_val, f"No-reset is not {expected_val} at cycle {i}!"
        assert dut.q_syncrst_o.value == expected_val, f"Synchronous is not {expected_val} at cycle {i}!"
        assert dut.q_asyncrst_o.value == 0, f"Asynchrousou is not 0 at cycle {i}!"

        await RisingEdge(dut.clk)
        await Timer(500, units="ns")
        assert dut.q_norst_o.value == expected_val, f"No-reset is not {expected_val} at cycle {i}!"
        assert dut.q_syncrst_o.value == 0, f"Synchronous is not 0 at cycle {i}!"
        assert dut.q_asyncrst_o.value == 0, f"Asynchrousou is not 0 at cycle {i}!"
        dut.reset.value = 0
        
        # 3) Go back to normal
        dut.d_i.value = val  # Assign the random value val to the input port d
        await RisingEdge(dut.clk)
        expected_val = val  # Save random value for next RisingEdge

    # Check the final input on the next clock
    await RisingEdge(dut.clk)
    assert dut.q_norst_o.value == expected_val, f"No-reset is not {expected_val} in last cycle!"
    assert dut.q_syncrst_o.value == expected_val, f"Synchronous is not {expected_val} in last cycle!"
    assert dut.q_asyncrst_o.value == expected_val, f"Asynchrousou is not {expected_val} in last cycle!"
    