# Данные по участникам, договорам и недобросовестным поставщикам для МСБ (Data Scientists)
module "edi_goszakup_smb" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  name = "goszakup-smb"

  partitions  = 4     # Default 4
  replicate   = true  # Default true
  retain_days = 3     # Default 1

}

# парсер для выгрузки данных из https://www.goszakup.gov.kz/ru и дальнейшей загрузкой в Kafka
module "edi_goszakup_smb_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "edi-goszakup"

  groups   = ["edi-goszakup-smb"]
  consumes = [module.edi_goszakup_smb.name]
  produces = [
      module.edi_goszakup_smb.name,
  ]
}

# выгрузка из кафки с последующей заливкой в hdfs. Упр. нереляционного. хранилища данных
module "nrds_goszakup_smb_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "nrds-goszakup"

  groups   = ["nrds-goszakup-smb"]
  consumes = [module.edi_goszakup_smb.name]
}
