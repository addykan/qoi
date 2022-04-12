# Build Stage
FROM ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y clang

## Add source code to the build stage.
ADD . /qoi
WORKDIR /qoi

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN mkdir build && \ 
    cd build/ && \
    clang -fsanitize=address,fuzzer -g -O0 ../qoifuzz.c -o qoifuzz

# Package Stage
FROM ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /qoi/build/qoifuzz /
