# Monitoring halyk auto marketing application
module "di_halykauto_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role     = "di-campaign-halyk-auto-card-payments"
  consumes = ["OW-TRANSACTIONS-EXP"]
  groups   = ["di-azs-marketing"]
}

