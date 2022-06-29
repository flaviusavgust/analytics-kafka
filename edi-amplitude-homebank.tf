# Действия пользователей в приложении Homebank (клики по событиям/покупки/просмотры экранов и другие)
module "edi_amplitude_homebank" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  name = "amplitude-homebank"

  partitions  = 8     # Default 4
  replicate   = true  # Default true
  retain_days = 3     # Default 1
}


# app1(Amplitude -> Kafka Producer) -> Topic -> app2(Kafka Consumer -> ACRMRO)
module "edi_amplitude_homebank_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "edi-amplitude-homebank"

  groups   = ["edi-amplitude-homebank"]
  consumes = [module.edi_amplitude_homebank.name]
  produces = [
      module.edi_amplitude_homebank.name,
  ]

}
