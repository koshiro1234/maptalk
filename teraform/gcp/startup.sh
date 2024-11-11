#!/bin/bash
apt-get update
apt-get install -y golang
HOME=/usr/local/go GOBIN=/usr/local/bin /usr/bin/go install github.com/nakai95/maptalk