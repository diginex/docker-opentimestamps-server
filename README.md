# docker-opentimestamps-server

## Usage

```bash
docker run --rm -it \
  -e BITCOIN_RPCCONNECT=<your-bitcoind-rpc> \
  -e BITCOIN_RPCPORT=<rpc-port> \
  -e BITCOIN_RPCUSER=<rpc-user> \
  -e BITCOIN_RPCPASSWORD=<rpc-password> \
  -p 14788:14788 \
  diginex/opentimestamps-server
```

Please note that the above exposes the server over HTTP publicly. You can use something like [`nginx-proxy`](https://github.com/jwilder/nginx-proxy) and [`letsencrypt-nginx-p9roxy-companion`](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion) to protect your users.
