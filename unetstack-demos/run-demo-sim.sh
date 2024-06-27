#!/bin/bash
(
    cd /Users/chinmay/Documents/Subnero/Projects/unet || exit

    # create an array to store pids
    pids=()

    bin/unet -b -p 8080 -a 1100 -all audio --no-soundcard --nodename "node1" --config /Users/chinmay/Desktop/subnero-arl-workshop/node1.toml &
    # store the pid into an array
    pids[0]=$!
    bin/unet -b -p 8081 -a 1101 -all audio --no-soundcard --nodename "node2" --config /Users/chinmay/Desktop/subnero-arl-workshop/node2.toml &
    pids[1]=$!
    bin/unet -b -p 8082 -a 1102 -all audio --no-soundcard --nodename "node3" --config /Users/chinmay/Desktop/subnero-arl-workshop/node3.toml &
    pids[2]=$!
    bin/unet -b -p 8083 -a 1103 -all audio --no-soundcard --nodename "node4" --config /Users/chinmay/Desktop/subnero-arl-workshop/node4.toml &
    pids[3]=$!
    bin/unet -b -p 8084 -a 1104 -all audio --no-soundcard --nodename "node5" --config /Users/chinmay/Desktop/subnero-arl-workshop/node5.toml &
    pids[4]=$!
    bin/unet -b -p 8085 -a 1105 -all audio --no-soundcard --nodename "node6" --config /Users/chinmay/Desktop/subnero-arl-workshop/node6.toml
    pids[5]=$!

    ( trap exit SIGINT ; read -r -d '' _ </dev/tty )
    # kill all the pids
    for pid in "${pids[@]}"; do
        echo "Killing $pid"
        kill "$pid"
    done
)

