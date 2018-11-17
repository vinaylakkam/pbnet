
See: https://hyperledger.github.io/composer/v0.19/reference/commands


############################ Business network commands ############################
####################################################################################

# Update the version property in package.json <-------
# Package the business network with new version

composer archive create --sourceType dir --sourceName . -a pbnet@0.0.9.bna

#Install
composer network install --card PeerAdmin@pbnet --archiveFile pbnet@0.0.9.bna

#Upgrade to the business network that was installed

composer network upgrade --card PeerAdmin@pbnet -n pbnet -V 0.0.9

#Regenerate REST API

composer-rest-server --card admin@pbnet -n never -u true -d N -w true

#Regenerate UI app (from pbn directory)

yo hyperledger-composer:angular


########################################## Publish REST API ############################
#######################################################################################

composer-rest-server -c admin@pbnet -n never -u true -d PBN -w true




######################################### Adding a new PEER node #######################
########################################################################################

1. crypto-config.xml -> Count
2. docker-compose.yaml -> update peers
3. connection.json -> update
4. Generate certs

cd composer

curl -sSL https://raw.githubusercontent.com/hyperledger/fabric/master/scripts/bootstrap.sh | bash -s 1.2.0 1.2.0 0.4.10 -s -d

rm -rf crypto-config

bin/cryptogen generate --config=./crypto-config.yaml
 
5. Update services/ca.org1.example.com/command section of docker-composer.yml and docker-compose-dev.yml to refer to correct ca.keyfile:
  - basename $(ls -1 crypto-config/peerOrganizations/org1.example.com/ca/*_sk)

  - Update PRIVATE_KEY value in ../createPeerAdminCard.sh to refer to correct private key file:
  	- ls -1 crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/keystore/*_sk


6. Regenerate genesis block and create channel transaction if configtx.yaml changes:

export FABRIC_CFG_PATH=$PWD
bin/configtxgen -profile ComposerOrdererGenesis -outputBlock ./composer-genesis.block

bin/configtxgen -profile ComposerChannel -outputCreateChannelTx ./composer-channel.tx -channelID composerchannel 

7. restart everything (run up.sh)



########################### AWS #################3

#Show volume usage
df -hT /dev/xvda1

