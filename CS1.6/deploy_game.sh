#!/bin/bash
MAINTAINER="MrSaintJCode"

_HEADER="
######################
- Counter-Strike 1.6 -
   Dedicated Server  
###################### 
Maintainer: ${MAINTAINER}
"

# Output Header
echo "$_HEADER"

# Creating Folder(s)
FOLDER_NAME="/root/cs_server"
if [ ! -d "$FOLDER_NAME" ]; then
	echo "[+] Creating - $FOLDER_NAME"
	mkdir $FOLDER_NAME
	chmod 777 -R $FOLDER_NAME
	[ ! -d "$FOLDER_NAME" ] && echo "${RED} [x] Unable to create $FOLDER_NAME" && exit 1
	echo "[✓] Folder Created"
else
	echo "[✓] Folder -$FOLDER_NAME exist"
fi

# Downloading File(s) 
# URL - http://cdn01.counterstrike.com.pk/web/files/hlds4linux_cspak.zip
SITE="cdn01.counterstrike.com.pk"
ZIP="hlds4linux_cspak.zip"
PATH="/web/files/${ZIP}"
echo "[+] Verifying Host Availability - ${SITE}"

/usr/bin/ping -c 1 $SITE >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "[✓] Reachable - $SITE"
else
	echo "$[x] Unreachable - $SITE"
	exit 1
fi

echo "[+] Downloading Game Files - ${SITE}${PATH}"
/usr/bin/wget -q "${SITE}${PATH}" -P $FOLDER_NAME

echo "[+] Verifying Download - ${ZIP}"
[ ! -f "${FOLDER_NAME}/${ZIP}" ] && echo "[X] Unable to Download Game Files - ${SITE}${PATH}" && exit 1
echo "[✓] Game Downloaded - ${FOLDER_NAME}/${ZIP}"

# Unpacking Zip File
GAME_FILES="${FOLDER_NAME}/Game"

echo "[+] Unpacking Zip - ${FOLDER_NAME}/${ZIP}"
/usr/bin/unzip -o "${FOLDER_NAME}/${ZIP}" -d "${GAME_FILES}"
/usr/bin/mv $GAME_FILES/hlds4linux_cspak/* $GAME_FILES/
[ "$(/usr/bin/ls -A $GAME_FILES/hlds4linux_cspak)" ] && echo "[x] Error Moving - ${GAME_FILES}/hlds4linux_cspak" && exit 1
/usr/bin/rm -R "${GAME_FILES}/hlds4linux_cspak"
echo "[✓] Unpacking Completed"

echo "[+] Cleaning up"
/usr/bin/rm -R "${FOLDER_NAME}/${ZIP}"
