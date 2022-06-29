# Parsing external data sources from data.egov.kz
module "hive_taxes" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  name = "hive-taxes-topic"

  # Optional parameters
  partitions  = 1     # Default 4
  replicate   = true # Default true
  retain_days = 30     # Default 1
}

# Parsing external data sources from stat.gov.kz
module "hive_statgov_gbdul" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  name = "hive-statgov-gbdul-topic"

  # Optional parameters
  partitions  = 1     # Default 4
  replicate   = true # Default true
  retain_days = 25     # Default 1
}

# Parsing external data sources
module "msb_external_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "msb-external-role"

  groups   = ["msb-external-group", "msb-external-group-qa", "msb-external-group-qa", "hive-statgov-gbdul-group-qa"]
  consumes = [module.hive_taxes.name, module.hive_statgov_gbdul.name]
  produces = [module.hive_taxes.name, module.hive_statgov_gbdul.name]
}

