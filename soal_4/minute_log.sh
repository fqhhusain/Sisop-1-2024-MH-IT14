#!/bin/bash
free -m > /home/vboxuser/log/memory.txt

du -sh /home/vboxuser/ > /home/vboxuser/log/size.txt

read -r -a mem_line <<< $(sed -n '2p' /home/vboxuser/log/memory.txt)
read -r -a swap_line <<< $(sed -n '3p' /home/vboxuser/log/memory.txt)

mem_total=${mem_line[1]}
mem_used=${mem_line[2]}
mem_free=${mem_line[3]}
mem_shared=${mem_line[4]}
mem_buff_cache=${mem_line[5]}
mem_available=${mem_line[6]}
swap_total=${swap_line[1]}
swap_used=${swap_line[2]}
swap_free=${swap_line[3]}
swap_shared=${swap_line[4]}
swap_buff=${swap_line[5]}
swap_available=${swap_line[6]}

read -r -a size_line <<< $(cat /home/vboxuser/log/size.txt
)

size=${size_line[0]}
dir=${size_line[1]}

cat << EOF > /home/vboxuser/log/metrics_$(date '+%Y%m%d%H%M%S').log
mem_total        : $mem_total
mem_used         : $mem_used
mem_free         : $mem_free
mem_shared       : $mem_shared
mem_buff/chache  : $mem_buff_cache
mem_available    : $mem_available
swap_total       : $swap_total
swap_used        : $swap_used
swap_free        : $swap_free
swap_shared      : $swap_shared
swap_buff/chace  : $swap_buff
swap_available   : $swap_available
$dir             : $size
EOF

chmod -R 700 /home/vboxuser/log/ 

# crontab
# * * * * * /home/vboxuser/log/minute_log.sh 
