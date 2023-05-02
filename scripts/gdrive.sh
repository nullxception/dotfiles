#!/bin/bash
#
# gdrive.sh
# a helper to compile gdrive cli with custom API
#

TMP=/tmp/gdrive-$USER
BIN=~/.local/bin/

log() {
    TAG=$(basename $0)
    printf "$TAG: %s\n" "$1"
}

rm -rf $TMP
mkdir $TMP
cd $TMP
[[ -d "~/go" ]] && GOPATH_USED=true

log "downloading gdrive source"
git clone https://github.com/gdrive-org/gdrive.git
cd gdrive

read -p "Your Google API client_id: " gdriveid
read -p "Your Google API client_secret: " gdrivesecret
sed -i "s|^const ClientId =.*|const ClientId = \"${gdriveid}\"|g" handlers_drive.go
sed -i "s|^const ClientSecret =.*|const ClientSecret = \"${gdrivesecret}\"|g" handlers_drive.go

log "building gdrive"
go get github.com/prasmussen/gdrive
go build -ldflags '-w -s'

log "installing gdrive"
mv gdrive ~/.local/bin/gdrive
chmod +x ~/.local/bin/gdrive

rm -rf $TMP
test "$GOPATH_USED" = "true" && rm -rf ~/go
