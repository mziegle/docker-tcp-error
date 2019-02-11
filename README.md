# Docker Network Error

## Prerequisites

- Docker version 18.09.0, build 4d60db4
- OS: Ubuntu 18.04; Kernel 4.15.0-45-generic

## Reproduction

### Build netcat-client image.

```
cd client
chmod +x build.sh
./build.sh
```

### Build netcat-server image.

```
cd server
chmod +x build.sh
./build.sh
```

### Start the experiment.

```
docker-compose up
```

### Verify

WARNING: Unfortunately this error occures not all the time. If you cannot observe the following then delete the old containers and
the network bridge and try it again.

Open Wireshark and inspect the created network bridge (`docker network ls`).
Verify that there are many tcp errors (retransmissions, Dup ACK and so on).

In the logs you should observe something like this:

```
netcat-client_1_48ac712b1acd | DNS fwd/rev mismatch: netcat-server != docker-tcp-error_netcat-server_1_5eedacd4a354.docker-tcp-error_default
netcat-server_1_5eedacd4a354 | listening on [any] 1234 ...
netcat-client_1_48ac712b1acd | netcat-server [172.22.0.2] 1234 (?) open
netcat-server_1_5eedacd4a354 | 172.22.0.1: inverse host lookup failed: Unknown host
netcat-server_1_5eedacd4a354 | connect to [172.22.0.2] from (UNKNOWN) [172.22.0.1] 36286
```

The netcat server logs a connection from the Gateway (in this case 172.22.0.1).
