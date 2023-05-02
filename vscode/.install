#!/bin/bash
vscodes=("Code"
         "Code - OSS"
         "VSCodium")

log "running VSCode Module installer"

iv=1
for v in "${vscodes[@]}"; do
    echo -e "$iv. $v"
    iv=$((iv+1))
done

echo -ne "=> select your VSCode variant (e.g, 3) : "
read -r nvsc
codename=${vscodes[$((nvsc-1))]}
if [ -z "$codename" ]; then
    echo "Invalid choice. aborting.."
    exit 1
else
    module_target="$HOME/.config/$codename/User"
fi
