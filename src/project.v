// Tiny Tapeout wrapper. clk, rst_n, and ena are not in the path.
module tt_um_one_cpu11_stack (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       clk,
    input  wire       rst_n,
    input  wire       ena
);
    wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

    one_cpu11_stack stack (
        .code(ui_in),
        .pin (uo_out)
    );

    assign uio_out = 8'h00;
    assign uio_oe  = 8'h00;
endmodule
