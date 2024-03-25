#!/bin/bash

HOUR=$(date '+%Y%m%d%H')
agg_file="/home/vboxuser/log/metrics_agg_${HOUR}.log"
declare -A min max sum count


for file in /home/vboxuser/log/metrics_${HOUR}*.log; do
    while IFS=": " read -r key value; do
        if [[ $value =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
            if [ -z ${min[$key]} ] || (( $(echo "$value < ${min[$key]}" | bc -l) )); then
                min[$key]=$value
            fi
            if [ -z ${max[$key]} ] || (( $(echo "$value > ${max[$key]}" | bc -l) )); then
                max[$key]=$value
            fi
            sum[$key]=$(echo "${sum[$key]:-0} + $value" | bc -l)
            count[$key]=$(( ${count[$key]:-0} + 1 ))
        fi
    done < "$file"
done

echo "minimum" > "$agg_file"
for key in "${!min[@]}"; do
    echo "$key : ${min[$key]}" >> "$agg_file"
done

echo -e "\nmaximum" >> "$agg_file"
for key in "${!max[@]}"; do
    echo "$key : ${max[$key]}" >> "$agg_file"
done

echo -e "\naverage" >> "$agg_file"
for key in "${!sum[@]}"; do
    avg=$(echo "scale=2; ${sum[$key]} / ${count[$key]}" | bc -l)
    echo "$key : $avg" >> "$agg_file"
done

declare -A min2 max2 sum2 count2

for file in /home/vboxuser/log/metrics_${HOUR}*.log; do
    while IFS=": " read -r key value; do
        if [[ $key =~ ^/ ]]; then
            size_in_gb=$(echo $value | awk '{
                suffix = substr($1, length($1));
                num = substr($1, 1, length($1)-1);
                if (suffix == "G") {
                    print num;
                } else if (suffix == "M") {
                    print num / 1024;
                } else if (suffix == "K") {
                    print num / 1024 / 1024;
                } else if (suffix == "T") {
                    print num * 1024;
                } else {
                    print num;
                }
            }')
            if [ -z ${min2[$key]} ] || (( $(echo "$size_in_gb < ${min2[$key]}" | bc -l) )); then
                min2[$key]=$value
            fi
            if [ -z ${max2[$key]} ] || (( $(echo "$size_in_gb > ${max2[$key]}" | bc -l) )); then
                max2[$key]=$value
            fi
            sum2[$key]=$(echo "${sum2[$key]:-0} + $size_in_gb" | bc -l)
            count2[$key]=$(( ${count2[$key]:-0} + 1 ))
        fi
    done < "$file"
done

echo "minimum" >> "$agg_file"
for key in "${!min2[@]}"; do
    echo "$key : ${min2[$key]}" >> "$agg_file"
done

echo -e "\nmaximum" >> "$agg_file"
for key in "${!max2[@]}"; do
    echo "$key : ${max2[$key]}" >> "$agg_file"
done

echo -e "\naverage" >> "$agg_file"
for key in "${!sum2[@]}"; do
    if [ ${count2[$key]} -ne 0 ]; then
        avg=$(echo "scale=2; ${sum2[$key]} / ${count2[$key]}" | bc -l)
        echo "$key : ${avg}G" >> "$agg_file"
    else
        echo "$key : N/A" >> "$agg_file"
    fi
done

#59 * * * * /bin/bash /home/vboxuser/log/aggregate_minutes_to_hourly_log.sh
