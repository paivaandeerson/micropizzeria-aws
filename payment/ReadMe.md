### To run on docker
```bash
docker network create micropizza-net
```

```bash
docker build -t payment-api:1 .
```

```bash
docker run --name payment-api \
  --network micropizza-net \
  -p 3000:3000 payment-api:1
```