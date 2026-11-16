`timescale 1ps/1ps
module tb;
    reg  [7:0] ui;
    reg  [7:0] uio_in;
    reg        clk;
    reg        rst_n;
    reg        ena;
    wire [7:0] uo;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    tt_um_one_cpu11_stack dut (
        .ui_in  (ui),
        .uo_out (uo),
        .uio_in (uio_in),
        .uio_out(uio_out),
        .uio_oe (uio_oe),
        .clk    (clk),
        .rst_n  (rst_n),
        .ena    (ena)
    );

    // same XOR, one level, 0.10 ns
    wire [7:0] refpin = ui ^ 8'hFF;
    wire [7:0] delayed;
    assign #(100) delayed = ui ^ 8'hFF;

    integer i, fails, seen, t0, got;

    initial begin
        fails  = 0;
        clk    = 1'b0;
        rst_n  = 1'b0;
        ena    = 1'b0;
        uio_in = 8'h00;
        ui     = 8'h00;

        // clock held. reset held. every code.
        for (i = 0; i < 256; i = i + 1) begin
            ui = i[7:0];
            #1000;
            if (uo !== (i[7:0] ^ 8'hFF)) begin
                $display("FAIL code %02x pin %02x", i[7:0], uo);
                fails = fails + 1;
            end
            if (uio_oe !== 8'h00 || uio_out !== 8'h00) begin
                $display("FAIL uio driven");
                fails = fails + 1;
            end
        end

        // clock, reset, and enable all move. the pin stays with the code.
        ui   = 8'h5B;
        #1000;
        seen = uo;
        rst_n = 1'b1;
        ena   = 1'b1;
        uio_in = 8'hFF;
        repeat (8) begin
            clk = ~clk;
            #1000;
            if (uo !== seen[7:0]) begin
                $display("FAIL clock moved the pin to %02x", uo);
                fails = fails + 1;
            end
        end
        if (seen[7:0] !== 8'hA4) begin
            $display("FAIL 5B came out %02x", seen[7:0]);
            fails = fails + 1;
        end

        // settle
        ui = 8'h00;
        #5000;
        ui = 8'hA5;
        t0  = $time;
        got = -1;
        repeat (20) begin
            #50;
            if (got < 0 && delayed === refpin) got = $time - t0;
        end

        $display("bytes %0d", 256);
        $display("fails %0d", fails);
        $display("settle_ps %0d", got);
        $display("pin_5B %02x", seen[7:0]);
        if (fails == 0 && seen[7:0] === 8'hA4) $display("PASS");
        else $display("FAIL");
        $finish;
    end
endmodule
