#!/bin/bash
logn=statsc.log
thresh=30000
#snmpsvr="135.227.226.98"
snmpsvr="192.168.231.59"
cntType="numOfAccumIPsecEnDecrKBs.1"
#gwkeys=()
#gwn=3
#for i in $(seq $gwn); do gwkeys+=("1052.1442840610.$i"); done

gwkeys=(1.1442840610.201 1.1442840642.101)

while :
do
    date +%m%d_%H%M%S | tee -a $logn
    i=0
    for k in ${gwkeys[@]}; do
        ((i++))
        read cnt[i] dur[i] tm[i] <<<$(/usr/bin/time -f %e snmpget -c private $snmpsvr -O qvU tmnxIPsecGWHistStatsValue64.$k.${cntType} tmnxIPsecGWHistStatsIntvDur.$k.${cntType} 2>&1 | tee -a $logn)
        cnt_d[i]=$((cnt[i] - cnt_p[i]))
        cnt_p[i]=${cnt[i]}
        dur_d[i]=$((dur[i] - dur_p[i]))
        dur_p[i]=${dur[i]}
        echo "gw$i: ${cnt_d[i]} ${dur_d[i]} ${tm[i]}" | tee -a $logn
        if [[ ${cnt_d[i]} -lt $thresh ]]; then
            echo "alarm!!!!! gw$i ${cnt_d[i]}"
        fi  
    done
    sleep 60
done
