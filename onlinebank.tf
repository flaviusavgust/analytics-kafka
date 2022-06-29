# Online Bank Credit Process application
module "ob_credit_process_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role     = "ob-credit-process"
  produces = ["ob-credit-process-events"]
  consumes = ["ob-credit-process-events"]
}

# Online Bank Online Credit MSB
module "onlinebank_onlinecredit_msb_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role     = "onlinebank-onlinecredit-msb"
  produces = ["onlinebank-onlinecredit-msb"]
  consumes = ["onlinebank-onlinecredit-msb"]
}

module "onlinebank_onlinecredit_msb_topic" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  name = "onlinebank-onlinecredit-msb"

  partitions  = 8     # Default 4
  replicate   = true  # Default true
  retain_days = 7     # Default 1
}


module "GOVERNMENT_CALLBACK_KGD_CSV_APP" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role     = "GOVERNMENT_CALLBACK_KGD_CSV"
  produces = ["GOVERNMENT_CALLBACK_KGD_CSV"]
  consumes = ["GOVERNMENT_CALLBACK_KGD_CSV"]
}

module "GOVERNMENT_CALLBACK_KGD_CSV_topic" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  name = "GOVERNMENT_CALLBACK_KGD_CSV"

  partitions  = 8     # Default 4
  replicate   = true  # Default true
  retain_days = 7     # Default 1
}
