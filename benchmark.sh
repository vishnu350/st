#!/bin/bash

# Data collect commands (Power Mode = Performance):
#  script -O log-st -c "for i in {1..1000}; do time st+ -e /bin/sh printf 'ABCDEFGHIJ0123456789%.0s\n' {1..5} 2>/dev/null; sleep 0.3; done"
#  script -O log-xt -c "for i in {1..1000}; do time xterm -e /bin/sh printf 'ABCDEFGHIJ0123456789%.0s\n' {1..5} 2>/dev/null; sleep 0.3; done"
#  script -O log-gt -c "for i in {1..1000}; do time time gnome-terminal -- /bin/sh printf 'ABCDEFGHIJ0123456789%.0s\n' {1..5} 2>/dev/null; sleep 0.3; done"

# Variables
_file="$1"
file=.tmp.results
sum=0
count=0

# Filter
dos2unix "$1"
grep real "$1" | tr '\t' ' ' > "$file"

# Main loop
while IFS= read -r line; do
    # Extract the time value (e.g., "0.034" from "real    0m0.034s")
    time=$(echo "$line" | awk '{print $2}' | sed 's/0m//g; s/s//g')
    sum=$(echo "$sum + $time" | bc)
    count=$((count + 1))
done < "$file"

# Calculate and display average
average=$(echo "scale=6; $sum / $count" | bc)
echo "Average: ${average}s"
rm "$file"

