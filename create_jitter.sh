#!/bin/bash

# The network interface to apply tc rules on, e.g., eth0
INTERFACE="$1"

# Maximum values for delay and jitter
MAX_DELAY="$2"  # in milliseconds
MAX_JITTER="$3"  # in milliseconds

# Function to apply random delay and jitter using tc
apply_random_tc() {
    # Generate random delay and jitter values within specified limits
    DELAY=$((RANDOM % MAX_DELAY))
    JITTER=$((RANDOM % MAX_JITTER))

    echo "Applying delay: ${DELAY}ms, jitter: ${JITTER}ms to ${INTERFACE}"
    sudo tc qdisc replace dev "$INTERFACE" root netem delay "${DELAY}ms" "${JITTER}ms" distribution normal
}

# Function to clear tc rules
clear_tc() {
    echo "Clearing tc rules on ${INTERFACE}"
    sudo tc qdisc del dev "$INTERFACE" root netem
}

# Trap to clear tc rules when the script is stopped
trap clear_tc EXIT

# Main loop: apply random delay and jitter at random intervals
while true; do
    apply_random_tc

    # Randomly sleep for 1-10 seconds before changing again
    SLEEP_TIME=$(( (RANDOM % 10) + 1 ))
    echo "Sleeping for ${SLEEP_TIME} seconds"
    sleep "$SLEEP_TIME"
done
