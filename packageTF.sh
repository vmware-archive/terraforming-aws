#!/usr/bin/env bash

docker build -t terraform-bundle -f DockerfileForMount .

docker run -it --rm \
       	-v /var/run/docker.sock:/var/run/docker.sock \
       	-v $(pwd):/wks  \
	-w /wks  \
	terraform-bundle \
	terraform-bundle package -os=linux -arch=amd64 terraform-bundle.hcl
