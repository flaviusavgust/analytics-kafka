# UCS access
module "ucs_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "ucs"

  groups   = ["ucs"]
  consumes = [
    "GG_XLS_ADMIN_OWJ_XLS_TXN_PUSH_QUEUE",
  ]
}
