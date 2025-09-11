# resourcespace-docker

ResourceSpace dockerized (also on ARM)

## download pre-build

```
docker pull davidloe/resourcespace
```

use `deploy-compose.yaml` with the clip plugin (URL: `http://clip:8000`)

## build your self

```
docker-compose up --build
```

## Setup

```
sudo chown 0:33 config.php
sudo chmod 775 config.php
```
