#!/bin/bash

# Define different sizes for testing
sizes=(1K 10K 100K 1M 10M 100M 250M)

# Print header of the results table in Markdown format
echo -e "| Size | Write Speed | Read Speed |"
echo -e "|------|-------------|------------|"

for size in "${sizes[@]}"; do
    total_write_speed=0
    total_read_speed=0
    passes=1

    # If the file size is smaller than 10MB, perform 4 passes
    if [ "$size" != "10M" ] && [ "$size" != "100M" ] && [ "$size" != "250M" ] && [ "$size" != "500M" ] && [ "$size" != "750M" ] && [ "$size" != "1G" ]; then
        passes=4
    fi

    for pass in $(seq 1 $passes); do
        # Test write speed for the given file size
        write_speed=$(sudo dd if=/dev/zero of=testfile bs=$size count=1 oflag=direct 2>&1 | grep copied | awk '{print $(NF-1)}')
        total_write_speed=$(echo "$total_write_speed + $write_speed" | bc)

        # Test read speed
        read_speed=$(sudo dd if=testfile of=/dev/null bs=$size 2>&1 | grep copied | awk '{print $(NF-1)}')
        total_read_speed=$(echo "$total_read_speed + $read_speed" | bc)

        # Remove the test file
        sudo rm -f testfile
    done

    # Calculate average values
    avg_write_speed=$(echo "scale=2; $total_write_speed / $passes" | bc)
    avg_read_speed=$(echo "scale=2; $total_read_speed / $passes" | bc)

    # Print results in a Markdown table format
    echo -e "| $size | ${avg_write_speed} MB/s | ${avg_read_speed} MB/s |"
done
