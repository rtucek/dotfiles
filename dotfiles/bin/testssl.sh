#!/bin/bash

docker run \
	-it \
	--rm \
	drwetter/testssl.sh:3.0 \
	"$@"
