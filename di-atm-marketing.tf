# Активность в банкомате
module "di_atm_marketing_topic_activity" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  name = "atm-marketing-activity"


  partitions  = 4     # Default 4
  replicate   = true  # Default true
  retain_days = 1     # Default 1
  }

# Результат отработки кампании по клиенту через банкомат
module "di_atm_marketing_topic_offer_response" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"


  name = "atm-marketing-activity-offer-response"


  partitions  = 4     # Default 4
  replicate   = true  # Default true
  retain_days = 1     # Default 1
}

# ATM marketing актуализация контактных данных, захват чужих клиентов
module "di_atm_marketing_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "di-atm-marketing"

 
  groups   = ["di-atm-marketing"]
  consumes = [module.di_atm_marketing_topic_offer_response.name]
  produces = [
      module.di_atm_marketing_topic_offer_response.name,
      module.di_atm_marketing_topic_activity.name,
  ]
}
