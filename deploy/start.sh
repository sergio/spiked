#!/bin/bash

cd /opt/spiked/latest/bin/
(./spiked-server 2>&1 | tee -a /var/log/spiked.log) & echo $! > /run/spiked-server.pid

