# Net Emulation (linux-kernel only)

This is simple wrapper around `tc` utility to test different network conditions in more realistic way than simple bandwidth trottling. Not limiting to Chrome browser and with more complex traffic shapes.

It simulates non-constant latency, bandwidth restrictions, and dropped/reordered/corrupted packets. 
Potentially you could add any traffic shapes by adding your preset to the script, by default it contains 7 presets:

Preset | Latency | Bandwidth | Packet-loss
:-- | --: | --: | --:
`gprs` | 500 | 50 | 2
`edge` | 300 | 250 | 1.5
`3g` | 250 | 750 | 1.5
`dial-up` | 185 | 40 | 2
`dsl` | 70 | 2000 | 2
`wifi` | 40 | 30000 | 0.2
`loss` (only packet-loss) | - | - | 2

## Installation

Ensure that you have `kernel-modules-extra` installed.

1. Copy this script and make it executable `chmod u+x`
2. From the root user run `net-emulation.sh 3g`
3. After your done run `net-emulation.sh reset` to reset network to default condition

## Options

By default ethernet interface is used, but you could change it to any other, for example, wifi by changing `NET_INTERFACE` value to `wlp3s0`.

```sh
net-emulation.sh gprs|edge|3g|dial-up|dsl|wifi|loss|reset
```

To reset emulation run `net-emulation.sh reset`.

To check active discipline use `tc -s qdisc` directly.

### More info

For more info see docs for [tc](https://wiki.linuxfoundation.org/networking/netem)

If you are not on linux-kernel take a look on [comcast](https://github.com/tylertreat/comcast)

