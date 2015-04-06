#!/bin/bash

# Fetch Sources

cd /usr/local/src

echo ""
echo ""
echo "====> PYTHON27-FFMPEG: Downloading source"
git clone --depth 1 https://github.com/l-smash/l-smash
git clone --depth 1 git://git.videolan.org/x264.git
hg clone https://bitbucket.org/multicoreware/x265
git clone --depth 1 git://github.com/mstorsjo/fdk-aac.git
git clone --depth 1 https://chromium.googlesource.com/webm/libvpx
git clone --depth 1 git://source.ffmpeg.org/ffmpeg
git clone --depth 1 git://git.opus-codec.org/opus.git
git clone --depth 1 https://github.com/mulx/aacgain.git
curl -Os http://www.tortall.net/projects/yasm/releases/yasm-${YASM_VERSION}.tar.gz
tar xzvf yasm-${YASM_VERSION}.tar.gz


echo ""
echo ""
echo "====> PYTHON27-FFMPEG: Done downloading source"
ls -la /usr/local/src/


# Build YASM

echo ""
echo ""
echo "====> PYTHON27-FFMPEG: Compiling YASM"
cd /usr/local/src/yasm-${YASM_VERSION}
./configure
make -j 8
make install

# Build L-SMASH

echo ""
echo ""
echo "====> PYTHON27-FFMPEG: Compiling L-SMASH"
cd /usr/local/src/l-smash
./configure
make -j 8
make install

# Build libx264

echo ""
echo ""
echo "====> PYTHON27-FFMPEG: Compiling LIBX264"
cd /usr/local/src/x264
./configure --enable-static
make -j 8
make install

# Build libx265

echo ""
echo ""
echo "====> PYTHON27-FFMPEG: Compiling LIBX265"
cd /usr/local/src/x265/build/linux
cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr ../../source
make -j 8
make install

# Build libfdk-aac

echo ""
echo ""
echo "====> PYTHON27-FFMPEG: Compiling LIBFDK-ACC"
cd /usr/local/src/fdk-aac
autoreconf -fiv
./configure --disable-shared
make -j 8
make install

# Build libvpx

echo ""
echo ""
echo "====> PYTHON27-FFMPEG: Compiling LIBVPX"
cd /usr/local/src/libvpx
./configure --disable-examples
make -j 8
make install

# Build libopus

echo ""
echo ""
echo "====> PYTHON27-FFMPEG: Compiling LIBOPUS"
cd /usr/local/src/opus
./autogen.sh
./configure --disable-shared
make -j 8
make install

# Build ffmpeg.

echo ""
echo ""
echo "======================================="
echo "====> PYTHON27-FFMPEG: Compiling FFMPEG"
echo "======================================="
cd /usr/local/src/ffmpeg
./configure --extra-libs="-ldl" \
            --enable-gpl \
            --enable-libass \
            --enable-libfdk-aac \
            --enable-libfontconfig \
            --enable-libfreetype \
            --enable-libfribidi \
            --enable-libmp3lame \
            --enable-libopus \
            --enable-libtheora \
            --enable-libvorbis \
            --enable-libvpx \
            --enable-libx264 \
            --enable-libx265 \
            --enable-nonfree

make -j 8
make install
echo ""
echo "======================================="

# Build aacgain

cd /usr/local/src/aacgain/mp4v2
./configure && make -k -j 8 # some commands fail but build succeeds
cd /usr/local/src/aacgain/faad2
./configure && make -k -j 8 # some commands fail but build succeeds
cd /usr/local/src/aacgain
./configure && make -j 8 && make install

# Remove all tmpfile

rm -rf /usr/local/src
