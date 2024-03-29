#!/bin/bash


#Take node version as input
echo "What version of node do you want to use?"
read -p "Node v" VERSION
URL=https://github.com/nodejs/node/archive/refs/tags/v"$VERSION".tar.gz
SCRIPT_PATH=$(dirname "$0")

echo "Installing Node v"$VERSION"..."

code=$(curl "$URL" -L --silent --fail --retry 5 --retry-max-time 15 --retry-connrefused --connect-timeout 5 -o ./node.tar.gz --write-out "%{http_code}")

if [ "$code" != "200" ]; then
	echo "Unable to download node: $code" && false
	echo "Check that node v"$VERSION" is an existing version"
	exit 1
fi

echo "Unpacking.."
mkdir node_source
tar xzf node.tar.gz -C ./node_source --strip-components 1

#Swap with modified time.cc
echo "Modifying node source code.."
cp "$SCRIPT_PATH"/time.cc ./node_source/deps/v8/src/base/platform



#Build from Source
docker run -d -v "$(pwd)/node_source" node-tm-builder
echo "When container has finished running, copy node.tar.gz using the following command:"
echo "docker cp node-tm-builder:/app/source_code/node.tar.gz"

#./node_source/configure
#make -C ./node_source -j4
#
#echo "Moving binaries and dependencies.."
#mkdir binaries
#mv node_source/out/Release/node binaries
#
#echo "Compressing binaries.."
#tar -czvf node.tar.gz binaries
#
#echo "Cleaning up.."
#rm -rf binaries
#
#echo "Done!\n"
#
#echo "Commit binary to github or some other hosting platform and retrieve a pubilcly accessible URL for it for the next step \n"
#echo "When you're done, run configureBuildPack. It will ask for this URL"
