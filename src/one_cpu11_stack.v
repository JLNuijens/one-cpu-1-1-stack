// ONE CPU 1.1 Stack
// One stack. The code is the signal. The preload is a wire at 1.
// Each output bit is that bit of the code against the 1. One XOR.
module one_cpu11_stack (
    input  wire [7:0] code,
    output wire [7:0] pin
);
    assign pin = code ^ 8'hFF;
endmodule
