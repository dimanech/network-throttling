#!/bin/bash

NET_INTERFACE=eth0

limit () {
    # $1 - latency
    # $2 - bandwidth
    # $3 - packet-lost
    tc qdisc add dev $NET_INTERFACE root netem delay $1ms 50ms distribution normal rate $2kbps loss $3% reorder 0.02 duplicate 0.05 corrupt 0.01 
}

reset () {
    tc qdisc del dev $NET_INTERFACE root netem
}

case "$1" in
    gprs)
        limit 500 50 2
    ;;
    edge)
        limit 300 250 1.5
    ;;
    3g)
        limit 250 750 1.5
    ;;
    dial-up)
        limit 185 40 2
    ;;
    dsl)
        limit 70 2000 2
    ;;
    wifi)
        limit 40 30000 0.2
    ;;
    loss)
        limit 0 0 2
    ;;
    reset)
        reset && \
        echo "$NET_INTERFACE queueing discipline deleted"
    ;;
esac
