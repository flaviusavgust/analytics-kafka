# События по тарифным пакетам, для контакта с клиентом
module "cbs_tarif_data_contact_topic" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  name = "cbs-tarif-contact"

  partitions  = 4     # Default 4
  replicate   = true  # Default true
  retain_days = 1     # Default 1
}
