apt-get install -y jq tree

if(systemctl -q is-active spiked-server)
then
    echo "Stopping service..."
    systemctl stop spiked-server
fi
    
VERSION=$(cat buildstate.json | jq -r '.version')
NEWDIR=/opt/spiked/$VERSION

echo "Installing new version $VERSION in $NEWDIR"
mkdir -p $NEWDIR/bin
mkdir -p $NEWDIR/sbin

echo "Copying files..."
cp spiked-server $NEWDIR/bin/spiked-server
cp start.sh $NEWDIR/sbin/start.sh
cp stop.sh $NEWDIR/sbin/stop.sh

echo "Setting permissions..."
chmod +x $NEWDIR/bin/spiked-server 
chmod +x $NEWDIR/sbin/*.sh


echo "Symlinking new version..."
ln -nsf $NEWDIR /opt/spiked/latest 

echo "Installing systemd service.."

cp spiked-server.service /lib/systemd/system/spiked-server.service

if [ -f /etc/systemd/system/spiked-server ]
then
    systemctl enable spiked-server
else
    systemctl daemon-reload
fi

echo "Starting service..."
systemctl start spiked-server
