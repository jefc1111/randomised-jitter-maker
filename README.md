# Randomised Jitter Maker

Uses the `tc` utility to create network latency and jitter, changing the value periodically to simulate remote networks' variable network conditions.


## Instructions

Run `./create_jitter.sh eth1 20 10` where eth1 is the network interface, 20 is the maximum latency value in milliseconds, and 10 is the maximum value for jitter.

