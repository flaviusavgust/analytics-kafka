# HAdoop access (Rinat)
module "adh" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "adh"

  groups   = ["adh-test", "adh", "spark-executor-adh","spark-*"]
  consumes = [
    "amplitude-homebank",
    "OW-TRANSACTIONS-EXP",
    "goszakup-smb",
    "samruk-registries",
  ]
  
}
