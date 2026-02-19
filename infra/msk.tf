# 1. Provide the MSK Cluster
module "msk_cluster" {
  source  = "terraform-aws-modules/msk-kafka-cluster/aws"
  version = "~> 2.0"

  name                   = "ecommerce-event-bus"
  kafka_version          = "3.5.1"
  number_of_broker_nodes = 2 #The total number of EC2 instances (brokers) running Kafka - balancing cost, availability, and performance

  # E-commerce clusters should be in private subnets
  broker_node_client_subnets = ["subnet-123", "subnet-456", "subnet-789"]
  broker_node_instance_type  = "kafka.t3.small" # Use larger for prod
  
  # Security: IAM is recommended for AWS-native integrations
  client_authentication = {
    sasl = { iam = true }
  }
}

# 2. Provide the Topic (using a Kafka provider)
provider "kafka" {
  bootstrap_servers = module.msk_cluster.bootstrap_brokers_sasl_iam
  tls_enabled       = true
}

resource "kafka_topic" "order_finished" {
  name               = "order-finished-topic"
  replication_factor = 2 # 2 copies (replicas), 1 per node
  partitions         = 2 # parallelism. One partition can only be read by one Lambda instance at a time.

  config = {
    "cleanup.policy" = "delete"
    "retention.ms"   = "604800000" # 7 days retention
  }
}
