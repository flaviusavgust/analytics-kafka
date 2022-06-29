# Поиск отказных операций среди транзакций ow
module "di_ow_transactions_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role     = "di-ow-transactions"
  consumes = ["OW-TRANSACTIONS-EXP"]
  groups   = ["di-ow-transactions"]
}


