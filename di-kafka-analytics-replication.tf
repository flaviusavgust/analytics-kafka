# DI kafka replication access
module "di_kafka_analytics_replication" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "di-kafka-analytics-replication"

  produces = [
    module.halyk_bpm_topic_united_non_credit_info.name,      
  ]

  consumes = [
    module.halyk_bpm_topic_united_non_credit_info.name,      
  ]
}
