`timescale 1ns / 1ps
module mips_tb;
    reg         clk;
    reg         rst_n;
    wire [31:0] pc_out;
    wire [31:0] alu_result;

    integer cycle;
    reg pass_ori;

    mips uut (
        .clk(clk),
        .rst_n(rst_n),
        .pc_out(pc_out),
        .alu_result(alu_result)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("mips.vcd");
        $dumpvars(0, mips_tb);
    end

    initial begin
        rst_n   = 0;
        cycle   = 0;
        pass_ori = 1'b0;
        #10;
        rst_n = 1;

        $display("=================================================================");
        $display("   MIPS Single Cycle Simulation  (ori support test)");
        $display("=================================================================");
        $display(" cyc | PC   | instr    | op | aluC | aluRes |  $1  $2  $3  $7");

        repeat (13) begin
            @(negedge clk);
            #1;
            cycle = cycle + 1;
            $display(" %2d  | %h | %h | %h |  %h  |  %0d\t| %0d  %0d  %0d  %0d",
                cycle,
                pc_out,
                uut.instr,
                uut.instr[31:26],
                uut.alu_ctrl,
                alu_result,
                uut.u_datapath.u_reg_file.rf[1],
                uut.u_datapath.u_reg_file.rf[2],
                uut.u_datapath.u_reg_file.rf[3],
                uut.u_datapath.u_reg_file.rf[7]
            );
        end

        $display("-----------------------------------------------------------------");
        $display("Final register state:");
        $display("  $1 = %0d (expect 10)", uut.u_datapath.u_reg_file.rf[1]);
        $display("  $2 = %0d (expect 15  <- ori $2,$1,15 : 10 | 15)", uut.u_datapath.u_reg_file.rf[2]);
        $display("  $3 = %0d (expect 15  <- add $3,$1,$2)", uut.u_datapath.u_reg_file.rf[3]);
        $display("  $4 = %0d (expect  5  <- sub)",         uut.u_datapath.u_reg_file.rf[4]);
        $display("  $5 = %0d (expect  0  <- and)",         uut.u_datapath.u_reg_file.rf[5]);
        $display("  $6 = %0d (expect 15  <- or)",          uut.u_datapath.u_reg_file.rf[6]);
        $display("  $7 = %0d (expect 15  <- lw)",          uut.u_datapath.u_reg_file.rf[7]);

        pass_ori = (uut.u_datapath.u_reg_file.rf[2] === 32'd15);
        $display("-----------------------------------------------------------------");
        if (pass_ori)
            $display(" RESULT: PASS  ori $2,$1,15 produced $2 = 15");
        else
            $display(" RESULT: FAIL  ori did not produce expected $2 = 15 (got %0d)",
                     uut.u_datapath.u_reg_file.rf[2]);
        $display("=================================================================");
        $finish;
    end
endmodule
