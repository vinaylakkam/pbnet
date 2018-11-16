# pbn (Payer Blockchain Network)

## Setup
---

**ref**: https://hyperledger.github.io/composer/latest/installing/installing-prereqs.html

**On Ubuntu, install pre-requisites** (~4 mins) 

- `curl -O https://hyperledger.github.io/composer/latest/prereqs-ubuntu.sh`
- `chmod u+x prereqs-ubuntu.sh`
- `./prereqs-ubuntu.sh`

**Install Development Environment - Node modules** (~10 mins)

- `sudo chown -R ubuntu /usr/local/lib`
- `sudo apt install npm`
- `npm install -g composer-cli@0.20`
- `npm install -g composer-rest-server@0.20`
- `npm install -g generator-hyperledger-composer@0.20`
- `npm install -g yo`
- `npm install -g composer-playground@0.20`

## Run
---

**ref**: https://hyperledger.github.io/composer/latest/tutorials/developer-tutorial

- `cd && git clone https://bitbucket.org/vlakkam/pbnet.git`

- `cd pbnet`
- `bash up.sh`

## Use it 
---

**ref**: https://hyperledger.github.io/composer/latest/tutorials/developer-tutorial


- `cd pbn`

Create a REST API

- `composer-rest-server -c admin@pbnet -n never -u true -d PBN -w true`

Open: http://localhost:3000 

Run UI 

- `cd pbn-ui`
- `npm install`
- `npm start`

Open: http://localhost:4200 


## Upgrade the network
---
**ref**: https://hyperledger.github.io/composer/latest/business-network/upgrading-bna

Update the version property in package.json

Package the business network with new version

- `composer archive create --sourceType dir --sourceName . -a pbn@0.0.3.bna`

Install

- `composer network install --card PeerAdmin@hlfv1 --archiveFile pbn@0.0.2.bna`

Upgrade to the business network that was installed

- `composer network upgrade -c PeerAdmin@hlfv1 -n pbn -V 0.0.2`

Regenerate REST API

- `composer-rest-server -c admin@pbn -n never -u true -d N -w true`

Regenerate UI app (from pbn directory)

- `yo hyperledger-composer:angular`
