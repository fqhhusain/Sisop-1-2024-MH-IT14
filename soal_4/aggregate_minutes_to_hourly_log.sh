#!/bin/bash

# Set the directory where log files are stored
LOG_DIR="/home/vboxuser/log"
HOUR=$(date '+%Y%m%d%H')

# Initialize variables for aggregation
total_lines=0
total_mem_total=0
total_mem_used=0
total_mem_free=0
total_mem_shared=0
total_mem_buff=0
total_mem_available=0
total_swap_total=0
total_swap_used=0
total_swap_free=0
total_path_size=0

# Initialize variables for minimum and maximum
min_mem_total=99999999
max_mem_total=0
min_mem_used=99999999
max_mem_used=0
max_mem_free=0
max_mem_shared=0
max_mem_buff=0
max_mem_available=0
max_swap_total=0
max_swap_used=0
max_swap_free=0
max_path_size=0
min_mem_free=99999999
min_mem_shared=99999999
min_mem_buff=99999999
min_mem_available=99999999
min_swap_total=99999999
min_swap_used=99999999
min_swap_free=99999999
min_path_size=99999999

# Loop through log files generated at the same minute
for file in /home/vboxuser/log/metrics_${HOUR}*.log; do
    # Extract values from the log file
    while IFS="," read -r mem_total mem_used mem_free mem_shared mem_buff mem_available swap_total swap_used swap_free path path_size
    do 

    # Precompute path size (remove 'G' and convert to MB)
    path_size="${path_size//G}"
    path_size=$((path_size * 1024))

    # Update aggregation variables
    total_lines=$((total_lines + 1))
    total_mem_total=$((total_mem_total + mem_total))
    total_mem_used=$((total_mem_used + mem_used))
    total_mem_free=$((total_mem_free + mem_free))
    total_mem_shared=$((total_mem_shared + mem_shared))
    total_mem_buff=$((total_mem_buff + mem_buff))
    total_mem_available=$((total_mem_available + mem_available))
    total_swap_total=$((total_swap_total + swap_total))
    total_swap_used=$((total_swap_used + swap_used))
    total_swap_free=$((total_swap_free + swap_free))
    total_path_size=$((total_path_size + path_size))

    # Update minimum and maximum values
    min_mem_total=$((mem_total < min_mem_total ? mem_total : min_mem_total))
    max_mem_total=$((mem_total > max_mem_total ? mem_total : max_mem_total))
    min_mem_used=$((mem_used < min_mem_used ? mem_used : min_mem_used))
    max_mem_used=$((mem_used > max_mem_used ? mem_used : max_mem_used))
    min_mem_free=$((mem_free < min_mem_free ? mem_free : min_mem_free))
    max_mem_free=$((mem_free > max_mem_free ? mem_free : max_mem_free))
    min_mem_shared=$((mem_shared < min_mem_shared ? mem_shared : min_mem_shared))
    max_mem_shared=$((mem_shared > max_mem_shared ? mem_shared : max_mem_shared))
    min_mem_buff=$((mem_buff < min_mem_buff ? mem_buff : min_mem_buff))
    max_mem_buff=$((mem_buff > max_mem_buff ? mem_buff : max_mem_buff))
    min_mem_available=$((mem_available < min_mem_available ? mem_available : min_mem_available))
    max_mem_available=$((mem_available > max_mem_available ? mem_available : max_mem_available))
    min_swap_total=$((swap_total < min_swap_total ? swap_total : min_swap_total))
    max_swap_total=$((swap_total > max_swap_total ? swap_total : max_swap_total))
    min_swap_used=$((swap_used < min_swap_used ? swap_used : min_swap_used))
    max_swap_used=$((swap_used > max_swap_used ? swap_used : max_swap_used))
    min_swap_free=$((swap_free < min_swap_free ? swap_free : min_swap_free))
    max_swap_free=$((swap_free > max_swap_free ? swap_free : max_swap_free))
    min_path_size=$((path_size < min_path_size ? path_size : min_path_size))
    max_path_size=$((path_size > max_path_size ? path_size : max_path_size))
    done < <(sed -n '2p' "$file")
done

# Calculate averages
average_mem_total=$((total_mem_total / total_lines))
average_mem_used=$((total_mem_used / total_lines))
average_mem_free=$((total_mem_free / total_lines))
average_mem_shared=$((total_mem_shared / total_lines))
average_mem_buff=$((total_mem_buff / total_lines))
average_mem_available=$((total_mem_available / total_lines))
average_swap_total=$((total_swap_total / total_lines))
average_swap_used=$((total_swap_used / total_lines))
average_swap_free=$((total_swap_free / total_lines))
average_path_size=$((total_path_size / total_lines))

average_path_size=$(echo "$average_path_size / 1000" | bc)"G"
min_path_size=$(echo "$min_path_size / 1000" | bc)"G"
max_path_size=$(echo "$max_path_size / 1000" | bc)"G"

# Write aggregated results to the summary file
summary_file="$LOG_DIR/metrics_agg_$(date '+%Y%m%d%H').log"
echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > "$summary_file"
echo "minimum,$min_mem_total,$min_mem_used,$min_mem_free,$min_mem_shared,$min_mem_buff,$min_mem_available,$min_swap_total,$min_swap_used,$min_swap_free,/home/vboxuser,$min_path_size" >> "$summary_file"
echo "maximum,$max_mem_total,$max_mem_used,$max_mem_free,$max_mem_shared,$max_mem_buff,$max_mem_available,$max_swap_total,$max_swap_used,$max_swap_free,/home/vboxuser,$max_path_size" >> "$summary_file"
echo "average,$average_mem_total,$average_mem_used,$average_mem_free,$average_mem_shared,$average_mem_buff,$average_mem_available,$average_swap_total,$average_swap_used,$average_swap_free,/home/vboxuser,$average_path_size" >> "$summary_file"

#59 * * * * /bin/bash /home/vboxuser/log/aggregate_minutes_to_hourly_log.sh
