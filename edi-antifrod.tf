# Антифрод, статистика смены доверенного номера
module "edi_antifrod" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  name = "SPM_ChangePhone"

  partitions  = 2     # Default 4
  replicate   = true  # Default true
  retain_days = 7     # Default 1

}

# Ответственное лицо 00047917
module "edi_antifrod_csm_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "ANTIFROD_CSM"

  groups   = ["ANTIFROD"]
  consumes = [module.edi_antifrod.name]
  produces = []
}

# Ответственное лицо 00025504
module "edi_antifrod_pds_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "ANTIFROD_PDS"

  groups   = ["ANTIFROD"]
  consumes = []
  produces = [module.edi_antifrod.name]
}
