# Monitoring halyk auto marketing application
module "di_parking_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role     = "di-campaign-parking"
  consumes = ["OW-TRANSACTIONS-EXP"]
  groups   = ["di-parking-1"]
}
