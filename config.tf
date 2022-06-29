terraform {
  backend "http" {
  }
  required_providers {
    kafka = {
      source  = "Mongey/kafka"
      version = "0.3.3"
    }
  }
}

variable "kafka_role" {
  type        = string
  description = "Role to use, when connecting to kafka cluster"
}

variable "kafka_token" {
  type        = string
  description = "Token to use, when connecting to Kafka cluster"
}

variable "kafka_broker" {
  type        = string
  description = "Kafka broker to connect to"
}

provider "kafka" {
  bootstrap_servers = [var.kafka_broker]
  tls_enabled       = false
  sasl_username     = var.kafka_role
  sasl_password     = var.kafka_token
}
