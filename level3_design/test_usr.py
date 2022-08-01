import cocotb
from cocotb.triggers import Timer
import random


@cocotb.test()
async def test_mux(dut):
