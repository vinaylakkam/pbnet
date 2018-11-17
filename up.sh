#!/bin/bash

#PBNET


# Start fabric 
cd ~/pbnet
cd ./fabric-dev-servers
export FABRIC_VERSION=hlfv12
export MSYS_NO_PATHCONV=1
./stopFabric.sh
./teardownFabric.sh
./teardownAllDocker.sh
./downloadFabric.sh
./startFabric.sh

# Delete existing cards
composer card delete -c PeerAdmin@pbnet
composer card delete -c admin@pbnet

rm -fr ~/.composer

./createPeerAdminCard.sh

# Create peeradmin card; Note: this is not needed everytime. we can just use the created card
#composer card create -p connection.json -u PeerAdmin -c ./peeradmin-certs/Admin@org1.example.com-cert.pem -k ./peeradmin-certs/d348cb10a9901c0c127e7b5d53c04971108ddac3993bc9ceb9a45aa39343e44e_sk -r PeerAdmin -r ChannelAdmin

composer card import -f PeerAdmin@pbnet.card
 

# deploy
composer network install -c PeerAdmin@pbnet -a ../business-net/pbnet@0.0.7.bna

composer network start -c PeerAdmin@pbnet --networkName pbnet --networkVersion 0.0.8 -A admin -S adminpw  

#composer network upgrade -c PeerAdmin@pbnet --networkName pbnet --networkVersion 0.0.8 

composer card import -f admin@pbnet.card

composer card list

composer network ping -c admin@pbnet

# Publish REST API

# composer-rest-server -c admin@pbnet -n never -u true -d PBN -w true
