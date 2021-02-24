FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade && \
    apt-get -y autoremove && \
    apt-get install -y build-essential cmake && \
    apt-get install -y libgtkglext1-dev libvtk6-dev && \
    apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev && \
    apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev && \
    apt-get install -y libtbb-dev libeigen3-dev && \
    apt-get install -y python-dev python-tk python-numpy python3-dev python3-tk python3-numpy && \
    apt-get install -y ant default-jdk && \
    apt-get install -y doxygen

RUN apt-get install -y unzip wget && \
    cd ~ && \
    wget https://github.com/Itseez/opencv/archive/3.0.0.zip && \
    unzip 3.0.0.zip && \
    rm 3.0.0.zip && \
    cd opencv-3.0.0 && \
    mkdir build && \
    cd build && \
    cmake -DWITH_TBB=ON -DWITH_XINE=ON -DWITH_IPP=ON .. && \
    make -j8 && \
    make install && \
    # Fix -lippicv linking error && \
    cp ~/opencv-3.0.0/3rdparty/ippicv/unpack/ippicv_lnx/lib/intel64/libippicv.a /usr/local/lib && \
    ldconfig

ENTRYPOINT [ "/bin/bash" ]

