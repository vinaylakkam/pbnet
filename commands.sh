#### Business network commands ####

# Update the version property in package.json <-------
# Package the business network with new version

composer archive create --sourceType dir --sourceName . -a pbn@0.0.3.bna

#Install
composer network install --card PeerAdmin@hlfv1 --archiveFile pbn@0.0.2.bna

#Upgrade to the business network that was installed

composer network upgrade -c PeerAdmin@hlfv1 -n pbn -V 0.0.2

#Regenerate REST API

composer-rest-server -c admin@pbn -n never -u true -d N -w true

#Regenerate UI app (from pbn directory)

yo hyperledger-composer:angular




#### Publish REST API ####

composer-rest-server -c admin@pbnet -n never -u true -d PBN -w true


