#! /bin/bash
# see plist file and http://www.splinter.com.au/using-launchd-to-run-a-script-every-5-mins-on/

date="$( date +%s )"
graphite_server=localhost
port=2003
host=${HOSTNAME/.lan/}_local

targets=(
  8.8.8.8
  192.168.1.254
  192.168.1.136
  www.marktplaats.nl
)

for target in ${targets[@]}; do
    #echo "the next file is $target ${target//./_}"
    ping_result=( $( ping -c 5 $target | awk -F '[ =/]' '/round-trip/ { print $9 }' ) )
    graphite_result=("${host}.ping.${target//./_}.latency_ms ${ping_result[*]} $date")
    echo $graphite_result | nc $graphite_server $port
    echo $graphite_result
done
