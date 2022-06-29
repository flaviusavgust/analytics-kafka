module "gg_monitoring" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "golden-gate-monitoring"

  consumes = var.golden_gate_topics
}
