FROM alpine:latest

RUN apk --update add nmap \
                     nmap-scripts \
                     git \
                     bash

RUN git clone https://github.com/khulnasoft-lab/vulnscan.git /usr/share/nmap/scripts/vulnscan

WORKDIR /usr/share/nmap/scripts/vulnscan

#Update CVE databases
CMD ["/bin/bash","updateFiles.sh"]

ENTRYPOINT ["nmap"]
CMD ["-h"]
