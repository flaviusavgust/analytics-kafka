module "di_campaign_cbs_tarif_contact" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role     = "di-campaign-cbs-tarif-contact"
  produces = ["cbs-tarif-contact"]
  consumes = ["cbs-tarif-contact"]
  groups   = ["di-campaign-cbs-tarif-contact"]
}
