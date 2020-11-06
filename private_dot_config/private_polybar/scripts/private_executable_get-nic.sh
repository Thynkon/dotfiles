#!/usr/bin/env bash

nmcli device status | grep ".*\ connected" | awk '{print $1}'
