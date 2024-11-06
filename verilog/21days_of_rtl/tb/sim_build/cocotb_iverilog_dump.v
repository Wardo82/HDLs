module cocotb_iverilog_dump();
initial begin
    $dumpfile("sim_build/day1.fst");
    $dumpvars(0, day1);
end
endmodule
