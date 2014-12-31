#! /bin/bash

# This is a simple script to pull out into from mobile digital thermometers
# as sold through CAO Gadgets. See here for more info: http://wirelesstags.myshopify.com/collections/all
# These tags are battery operated, then connect to a really small device wirelessly
# which is connected itself to your router via ethernet.

date="$( date +%s )"
graphite_server=localhost
graphite_root=wireless_tags
port=2003


# for API info for the wireless tags see: http://www.caogadgets.com/media/mytaglist.com/apidoc.html
# dependency on 'jq' (install with brew install jq)

echo "Curling info from mytaglist.com..."
curl -sS -X POST -H "Content-Type: application/json" -c /tmp/cookie-jar.txt  -d '{"email":"ojilles@gmail.com", "password":"aaaaaa"}' https://www.mytaglist.com/ethAccount.asmx/SignIn > /dev/null > /dev/null
curl -sS -H "Content-Type: application/json" -b /tmp/cookie-jar.txt  -d '{}' https://www.mytaglist.com/ethClient.asmx/GetTagList2 | tail -n 1 | jq . > /tmp/result.txt

IFS=,
RESULT=`cat /tmp/result.txt | jq --raw-output '.d[] | [.managerName, .name, .temperature, .lastComm, .alive, .signaldBm, .batteryVolt, .OutOfRange, .batteryRemaining] | @csv'`
#                                                 0             1      2             3          4       5           6             7            8

echo "Found the following tags + data"
while read -r line; do
				    echo " * $line"
						ITEMNR=0
						MANAGER_NAME=''
						TAG_NAME=''
						for ITEM in $line; do
										TMP=''
										case $ITEMNR in
														0)
																		MANAGER_NAME=`echo "$ITEM" | sed y/ABCDEFGHIJKLMNOPQRSTUVWXYZ\ /abcdefghijklmnopqrstuvwxyz_/ | sed s/\"//g `
																		TMP=
																		;;
														1)
																		TAG_NAME=`echo "$ITEM" | sed y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/ | sed s/\"//g | sed -E s/[[:space:]]+/_/g`
																		TMP=
																		;;
														2)
																		TMP="temperature $ITEM"
																		;;
														3)
																		TMP="lastComm $ITEM"
																		;;
														4)
																		T=`echo $ITEM | sed s/true/1/g | sed s/false/0/g`
																		TMP="alive $T"
																		;;
														5)
																		TMP="signaldBm $ITEM"
																		;;
														6)
																		TMP="batteryVolt $ITEM"
																		;;
														7)
																		T=`echo $ITEM | sed s/true/1/g | sed s/false/0/g`
																		TMP="OutOfRange $T"
																		;;
														8)
																		TMP="batteryRemaining $ITEM"
																		;;
														*)
																		# skip this, just set TMP to nothing
																		TMP=
																		;;
										esac

										if [ -n "$TMP" ] 
										then
														graphite_result="$graphite_root.$MANAGER_NAME.$TAG_NAME.$TMP $date"
														echo "  - $graphite_result"
														echo $graphite_result | nc $graphite_server $port
										fi
										ITEMNR=$((ITEMNR+1))
						done
done <<< "$RESULT"


#    {
#      "__type": "MyTagList.Tag2",
#      "managerName": "West Weer",
#      "mac": "2357FC6FF576",
#      "mirrors": [],
#      "notificationJS": null,
#      "name": "Tag 2 kira",
#      "uuid": "0ed0c1ce-7e5f-4550-86bf-28dab479e671",
#      "comment": "",
#      "slaveId": 2,
#      "tagType": 13,
#      "lastComm": 130644483963139730,
#      "alive": true,
#      "signaldBm": -77,
#      "batteryVolt": 3.126169821641448,
#      "beeping": false,
#      "lit": false,
#      "migrationPending": false,
#      "beepDurationDefault": 15,
#      "eventState": 0,
#      "pendingEventState": 0,
#      "tempEventState": 0,
#      "OutOfRange": false,
#      "solarVolt": 0,
#      "temperature": 26.552568435668945,
#      "tempCalOffset": 0,
#      "capCalOffset": 0,
#      "image_md5": null,
#      "cap": 27.47015380859375,
#      "capRaw": 0,
#      "az2": 0,
#      "capEventState": 0,
#      "shorted": false,
#      "thermostat": null,
#      "playback": null,
#      "ampData": null,
#      "postBackInterval": 0,
#      "rev": 0,
#      "version1": 0,
#      "freqOffset": 0,
#      "freqCalApplied": 0,
#      "reviveEvery": 0,
#      "LBTh": 0,
#      "enLBN": false,
#      "txpwr": 0,
#      "rssiMode": false,
#      "ds18": false,
#      "batteryRemaining": 0.99
#    },
#		...
#
