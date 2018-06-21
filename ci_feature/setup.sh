TMPDIR="/opt"
cd $TMPDIR

wget https://rashmi.blob.core.windows.net/bld-docker-image/Linux_ULINUX_1.0_x64_64_Release/docker-cimprov-1.0.0-33.universal.x86_64.sh

#create file to disable omi service startup script
touch /etc/.omi_disable_service_control
wget https://github.com/Microsoft/Docker-Provider/releases/download/2.0.0-3/docker-cimprov-2.0.0-3.universal.x86_64.sh
chmod 775 $TMPDIR/*.sh

#Extract omsbundle
$TMPDIR/omsagent-*.universal.x64.sh --extract
mv $TMPDIR/omsbundle* $TMPDIR/omsbundle
#Install omi
/usr/bin/dpkg -i $TMPDIR/omsbundle/100/omi*.deb

#Install scx
/usr/bin/dpkg -i $TMPDIR/omsbundle/100/scx*.deb
#$TMPDIR/omsbundle/bundles/scx-1.6.*-*.universal.x64.sh --install

#Install omsagent and omsconfig

/usr/bin/dpkg -i $TMPDIR/omsbundle/100/omsagent*.deb
/usr/bin/dpkg -i $TMPDIR/omsbundle/100/omsconfig*.deb
#/$TMPDIR/omsbundle/oss-kits/docker-cimprov-1.0.0-*.x86_64.sh --install
#Use downloaded docker-provider instead of the bundled one

/$TMPDIR/docker-cimprov-2.0.0-*.x86_64.sh --install

rm -rf $TMPDIR/omsbundle
rm -f $TMPDIR/omsagent*.sh
rm -f $TMPDIR/docker-cimprov*.sh
