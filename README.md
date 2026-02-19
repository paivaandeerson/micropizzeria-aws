# micropizzeria microservices

## On Premises mode

### 1. Run separeted containers
1. [marketplace-front](./marketplace/)
2. [marketplace-api](./marketplace/)
3. [payment-api](./payment/)

### 2. Run docker compose:

To update
<pre>docker-compose up --build</pre>

To run the available version
<pre>docker-compose up</pre>

To destroy
<pre>docker-compose down</pre>

2.1. RabbitMQ Manager http://localhost:15672/ guest / guest 
 
2.2. CMAK Kafka Manager http://localhost:9000/

![Technologies](util/technologies.png)


## Cloud mode



![cloud architecture](util/technologies%20aws.png)