#!/bin/bash

#Configure Heroku Buidlpack

echo "Enter the URL of the hosted node binary"
read -p "URL:" URL

heroku buildpacks:set https://github.com/Whitecx/heroku-buildpack-nodejs-timemachine.git

heroku config:set NODE_BINARY_URL="$URL"

echo "BuildPack Configured"
