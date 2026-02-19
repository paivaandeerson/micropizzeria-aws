#!/bin/bash
set -e

# Atualizar e instalar curl
apt-get update && apt-get install -y curl

# Baixar o rabbitmqadmin
curl -LO http://localhost:15672/cli/rabbitmqadmin

# Tornar executável
chmod +x rabbitmqadmin

# Declarar fila, exchange e binding
./rabbitmqadmin declare queue name=order-queue durable=true
./rabbitmqadmin declare exchange name=order-exchange type=direct durable=true
./rabbitmqadmin declare binding source='order-exchange' destination_type='queue' destination='order-queue' routing_key='order-routing-key'
