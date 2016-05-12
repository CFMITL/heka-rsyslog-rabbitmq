FROM ubuntu
RUN apt-get update && apt-get install -y cmake git mercurial ca-certificates make gcc libc6-dev patch sudo rsyslog dpkg debhelper fakeroot golang
RUN mkdir -p /home/heka
WORKDIR /home/heka
RUN git clone https://github.com/mozilla-services/heka . && . ./build.sh
WORKDIR /home/heka/build
RUN GOPATH=/home/heka/build/heka make install
ADD hekad.toml /etc/hekad.toml
ADD rsyslog.conf /etc/rsyslog.conf
CMD rsyslogd && hekad
