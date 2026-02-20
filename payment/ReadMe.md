### To run on docker
```bash
docker network create micropizza-net
```

```bash
docker build -t payment-container:1 .
```

```bash
docker run --name payment-container \
  --network micropizza-net \
  -p 3000:3000 payment-container:1
```