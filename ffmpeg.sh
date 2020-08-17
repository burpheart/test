#!/bin/sh
cd /tmp
git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git
cd nv-codec-headers
git checkout origin/sdk/9.0
sudo make
sudo make install
cd /tmp
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz 
tar zxvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure
make
make install
cd /tmp
git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg
cd ffmpeg 
./configure --disable-asm --disable-x86asm \
 --enable-cuda --enable-cuvid --enable-nvenc \
 --enable-nonfree --enable-libnpp \
 --extra-cflags=-I/usr/local/cuda/include \
 --extra-cflags=-fPIC --extra-ldflags=-L/usr/local/cuda/lib64
make -j8
sudo make install
