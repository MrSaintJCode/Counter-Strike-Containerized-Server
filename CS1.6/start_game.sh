#!/bin/bash
cd /root/cs_server/Game/
echo "[+] Starting Game"
./hlds_run -game cstrike +ip 0.0.0.0 +port 27015 +maxplayers 32 +map 'de_dust2_long_short' +sys_ticrate 1000
