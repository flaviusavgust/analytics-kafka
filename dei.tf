# Informatica dei access
module "dei" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "dei"

  groups   = [ "DEI_", "dei-" ]
  consumes = var.golden_gate_topics

  group_filter = "Prefixed"
}
