# Данные по реестрам и перечням самрук-казына (https://zakup.sk.kz/#/ext)
module "edi_samruk_registries" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  name = "samruk-registries"

  partitions  = 1     # Default 4
  replicate   = true  # Default true
  retain_days = 7     # Default 1

}

# https://zakup.sk.kz => parser => Kafka => hdfs => Hive
module "edi_samruk_registries_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "edi-samruk-registries"

  groups = ["edi-samruk-registries"]

  consumes = [module.edi_samruk_registries.name]
  produces = [
      module.edi_samruk_registries.name,
  ]
}
