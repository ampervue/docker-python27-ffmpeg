# docker-python27-ffmpeg

A Docker image running Ubuntu:trusty with Python 2.7 and latest FFMPEG (built from source)

## Python 3.5

Use newer https://github.com/ampervue/docker-ffmpeg

### To Build

~~~~
docker build -t <imageName> .
~~~~

### To pull and run from hub.docker.com

Docker Hub: https://registry.hub.docker.com/u/dkarchmervue/python27-ffmpeg/

Source and example: https://github.com/ampervue/docker-python27-ffmpeg

~~~~
docker pull dkarchmervue/python27-ffmpeg
docker run -ti dkarchmervue/python27-ffmpeg ffmpeg
~~~~

## Example

As an example, the python script uses FFMPEG to download a movie from the web and create a 100x100 thumbnail

~~~~
# Pull image
docker pull dkarchmervue/python27-ffmpeg

# Get example files and build new image
git clone https://github.com/ampervue/docker-python27-ffmpeg
cd example
docker build -t thumbnail .
docker run --rm -ti thumbnail --input http://techslides.com/demos/sample-videos/small.mp4

# Mount current directory on container so that file can be written back to host
docker run --rm -ti -v ${PWD}:/code thumbnail --file http://techslides.com/demos/sample-videos/small.mp4
ls thumbnail.jpg
open thumbnail.jpg

# To run with bash
docker run --entrypoint bash -ti thumbnail
~~~~