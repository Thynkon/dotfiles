#! /bin/sh

nmcli device status | grep ".*\ connected" | awk '{print $1}'
