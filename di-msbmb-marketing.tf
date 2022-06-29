# Создание топика
module "di_msbmb_marketing_topic" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  name = "ob-credit-process-events"


  partitions  = 4     # Default 4
  replicate   = true  # Default true
  retain_days = 1     # Default 1
  }

# Monitoring msbmb application
module "di_msbmb_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role     = "di-campaign-msbmb"
  consumes = ["ob-credit-process-events"]
  groups   = ["MSBMB"]
}
