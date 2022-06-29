# Analytical profile of clients - contracts
module "di_ow_contracts_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role     = "di_ow_contracts"
  consumes = ["OW-CONTRACTS-EXP"]
  groups   = ["di-ow-contracts"]
}
