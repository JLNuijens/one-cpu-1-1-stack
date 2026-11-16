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
| Pins out | 8, `uo[7:0]`. The byte, inverted. |
| Depth | 0.10 ns in the gate model |
| Output in that model | 10 GB/s, eight pins, one level |
| Held after the code leaves | No |
| Weight | Not computed |
| Any byte | Yes. None is decoded. |

```
uo = code XOR 11111111
```

A `5B` comes out `A4`. A `90` comes out `6F`.

The 10 GB/s figure is the gate model. It is not a pad measurement.

```
cd test && make
```

Apache-2.0.
