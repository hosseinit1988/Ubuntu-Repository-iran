#!/bin/bash
echo "Hossein.IT Repository ubuntu Auto"
set -e

UBUNTU_CODENAME="jammy"

MIRRORS=(
  "http://mirror.arvancloud.ir/ubuntu"
  "https://archive.ubuntu.petiak.ir/ubuntu/"
  "https://mirrors.pardisco.co/ubuntu/"
  "http://mirror.aminidc.com/ubuntu/"
  "http://mirror.faraso.org/ubuntu/"
  "https://ir.ubuntu.sindad.cloud/ubuntu/"
  "https://ubuntu-mirror.kimiahost.com/"
  "https://ubuntu.hostiran.ir/ubuntuarchive/"
  "https://ubuntu.bardia.tech/"
  "https://mirror.iranserver.com/ubuntu/"
  "https://ir.archive.ubuntu.com/ubuntu/"
  "https://mirror.0-1.cloud/ubuntu/"
  "http://linuxmirrors.ir/pub/ubuntu/"
  "http://repo.iut.ac.ir/repo/Ubuntu/"
  "https://ubuntu.shatel.ir/ubuntu/"
  "http://ubuntu.byteiran.com/ubuntu/"
  "https://mirror.rasanegar.com/ubuntu/"
  "http://mirrors.sharif.ir/ubuntu/"
  "http://mirror.ut.ac.ir/ubuntu/"
  "http://repo.iut.ac.ir/repo/ubuntu/"
  "http://mirror.asiatech.ir/ubuntu/"
  "http://mirror.iranserver.com/ubuntu/"
  "http://archive.ubuntu.com/ubuntu/"
)

echo "🔍 Please Wait... Ubuntu 22.04 ($UBUNTU_CODENAME)..."

WORKING_MIRROR=""

for MIRROR in "${MIRRORS[@]}"; do
    echo -n "⏳ TEST $MIRROR ... "
    if curl -s --head --max-time 5 "$MIRROR" | grep -q "200 OK"; then
        echo "✅ in Line"
        WORKING_MIRROR=$MIRROR
        break
    else
        echo "❌ Not Line"
    fi
done

if [ -z "$WORKING_MIRROR" ]; then
    echo "🚫 All Not In Line"
    exit 1
fi

echo "File Settings Source"
echo "    $WORKING_MIRROR"

sudo tee /etc/apt/sources.list > /dev/null <<EOF
deb ${WORKING_MIRROR} ${UBUNTU_CODENAME} main restricted universe multiverse
deb ${WORKING_MIRROR} ${UBUNTU_CODENAME}-updates main restricted universe multiverse
deb ${WORKING_MIRROR} ${UBUNTU_CODENAME}-backports main restricted universe multiverse
deb ${WORKING_MIRROR} ${UBUNTU_CODENAME}-security main restricted universe multiverse
EOF

echo ""
echo "✅ Settings OK"
echo "📦 Now - Command Inline Run"
echo ""
echo "sudo apt update"
echo ""
