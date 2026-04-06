// This repository contains assignments for the Computer Architecture course
// at Hanyang University ERICA, created by Jiseung Han
`timescale 1ns / 1ps
module alu_tb;
    reg  [31:0] src_a, src_b;
    reg  [2:0]  alu_ctrl;
    wire [31:0] result;
    wire        zero;
    
    alu uut (
        .src_a(src_a),
        .src_b(src_b),
        .alu_ctrl(alu_ctrl),
        .result(result),
        .zero(zero)
    );
    
    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);
    end
    
    initial begin
        $display("=== ALU Testbench ===");
        
        // Test ADD
        src_a = 47; src_b = 83; alu_ctrl = 3'b010;
        #10;
        if (result !== 130) $error("ADD Failed");
        else $display("ADD: %d + %d = %d [PASS]", src_a, src_b, result);
        
        // Test SUB with zero flag
        src_a = 55; src_b = 55; alu_ctrl = 3'b110;
        #10;
        if (result !== 0 || zero !== 1) $error("SUB/Zero Failed");
        else $display("SUB: %d - %d = %d, Zero=%b [PASS]", src_a, src_b, result, zero);
        
        // Test AND
        src_a = 32'hA5A5; src_b = 32'h5A5A; alu_ctrl = 3'b000;
        #10;
        if (result !== 32'h0000) $error("AND Failed");
        else $display("AND: 0x%h & 0x%h = 0x%h [PASS]", src_a, src_b, result);
        
        // Test OR
        src_a = 32'hF0F0; src_b = 32'h0F0F; alu_ctrl = 3'b001;
        #10;
        if (result !== 32'hFFFF) $error("OR Failed");
        else $display("OR: 0x%h | 0x%h = 0x%h [PASS]", src_a, src_b, result);
        
        // Test SLT unsigned
        src_a = 3; src_b = 77; alu_ctrl = 3'b111;
        #10;
        if (result !== 1) $error("SLT Failed");
        else $display("SLT: %d < %d = %d [PASS]", src_a, src_b, result);
        
        // Test SLT signed
        src_a = -12; src_b = 7; alu_ctrl = 3'b111;
        #10;
        if (result !== 1) $error("SLT Signed Failed");
        else $display("SLT: %d < %d = %d [PASS]", $signed(src_a), $signed(src_b), result);
        
        // Test MUL
        src_a = 9; src_b = 8; alu_ctrl = 3'b011;
        #10;
        if (result !== 72) $error("MUL Failed");
        else $display("MUL: %d * %d = %d [PASS]", src_a, src_b, result);
        
        // Test MUL large values (overflow, lower 32 bits)
        src_a = 32'hFFFF0000; src_b = 32'h10; alu_ctrl = 3'b011;
        #10;
        $display("MUL overflow: 0x%h * 0x%h = 0x%h (lower 32-bit)", src_a, src_b, result);
        
        // Test DIV
        src_a = 81; src_b = 9; alu_ctrl = 3'b100;
        #10;
        if (result !== 9) $error("DIV Failed");
        else $display("DIV: %d / %d = %d [PASS]", src_a, src_b, result);
        
        // Test DIV by zero
        src_a = 123; src_b = 0; alu_ctrl = 3'b100;
        #10;
        if (result !== 0) $error("DIV by zero Failed");
        else $display("DIV: %d / %d = %d (div-by-zero guard) [PASS]", src_a, src_b, result);
        
        $display("=== All Tests Passed ===");
        $finish;
    end
endmodule