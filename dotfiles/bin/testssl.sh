#!/bin/bash

docker run \
	-it \
	--rm \
	mvance/testssl:2.9.5 \
	"$@"
