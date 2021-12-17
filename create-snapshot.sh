#!/bin/bash

source /var/lib/swarm/configs/hornet.cfg

wwwPath=/var/www/html/snapshots
lsPath=/var/lib/hornet/snapshots/mainnet

if [ ! -d "$wwwPath" ]; then
    sudo mkdir -p $wwwPath
fi

index=$(curl -s -X GET "http://localhost:14265/api/v1/info" -H  "accept: application/json" -H "Authorization: Bearer ${hornetApiJwtToken}"|jq '.data.confirmedMilestoneIndex')
if [ $index -eq $index ]; then
    let index=$index-51
    curl -X POST http://localhost:14265/api/v1/control/snapshots/create -H "Content-Type: application/json" -H "Authorization: Bearer ${hornetApiJwtToken}" -d "{\"fullIndex\": ${index}}"

    if [ -f "$lsPath/full_snapshot_${index}.bin" ]; then
        sudo mv -f $lsPath/full_snapshot_${index}.bin $wwwPath/full_snapshot.bin
    fi
fi

exit 0