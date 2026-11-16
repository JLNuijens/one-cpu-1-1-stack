// ONE CPU 1.1 Stack
// One stack. The code is the signal. The preload is a wire at 1.
// No clock. Each output bit is that code bit against the 1.
//   pin[0] UART TX
//   pin[1] SPI SCLK
//   pin[2] SPI CS
//   pin[3] I2C SCL
//   pin[4] SPI MOSI
//   pin[5] I2C SDA
//   pin[7:6] the rest of the byte
module one_cpu11_stack (
    input  wire [7:0] code,
    output wire [7:0] pin
);
    assign pin = code ^ 8'hFF;
endmodule
