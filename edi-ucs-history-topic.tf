# топик для записи и чтения данных по коммуникациям Банка с клиентами
module "edi_ucs_history_topic" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  name = "UCS-HISTORY-TOPIC"

  partitions  = 8     # Default 4
  replicate   = true  # Default true
  retain_days = 7     # Default 1

}

# ucs
module "edi_ucs_history_topic_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "edi-ucs-history"

  groups   = ["ucs-history-group"]
  consumes = [module.edi_ucs_history_topic.name]
  produces = [
      module.edi_ucs_history_topic.name,
  ]
}