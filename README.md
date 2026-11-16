# ONE CPU 1.1 Stack

Joshua Luke Nuijens, Axiom 1 Technology, LLC.

One stack. The code is the signal. No clock in the path.

| | |
|---|---|
| Stacks | 1 |
| Clock | None. The code is the signal. |
| Preload | A wire at 1 |
| Gate | 1 XOR per pin |
| Code in | 8 bits, `ui[7:0]` |
| Depth | 0.10 ns in the gate model |
| Output in that model | 10 GB/s, eight pins, one level |
| Held after the code leaves | No |
| Any byte | Yes. None is decoded. |

The pin is that bit of the code against the 1.

| Pin | Line |
|---|---|
| `uo[0]` | UART TX |
| `uo[1]` | SPI SCLK |
| `uo[2]` | SPI CS |
| `uo[3]` | I2C SCL |
| `uo[4]` | SPI MOSI |
| `uo[5]` | I2C SDA |
| `uo[7:6]` | the rest of the byte |

```
uo = code XOR 11111111
```

Idle on a line is code bit 0, pin 1. The line goes to 0 when that code bit goes to 1. A UART start, an SPI clock, and an I2C clock are those bits changing. The chip does not count them.

A `5B` comes out `A4`.

The 10 GB/s figure is the gate model. It is not a pad measurement.

```
cd test && make
```

Apache-2.0.
