#!/bin/bash

while true ; do echo "test"; sleep 0.5; done | nc -v netcat-server 1234
