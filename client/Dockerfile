FROM ubuntu

COPY send.sh /
RUN chmod +x send.sh
RUN apt-get update && apt-get --assume-yes install netcat

CMD ./send.sh