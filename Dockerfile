FROM alpine:3.17
#Install gcc to compile node
RUN apk update && apk add --no-cache python3 make g++ libuv-dev openssl-dev linux-headers tar
#Make sure path to source code is an argument..
RUN mkdir /data
CMD cd /app/source_code && ./configure && make -j4 && mkdir binaries && mv node_source/out/Release/node binaries && tar -czvf node.tar.gz binaries

