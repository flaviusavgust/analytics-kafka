# Задолженности КГД по МСБ; Topic -> app(Kafka Consumer -> ACRMRO)
module "edi_government_callback_kgd_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "edi-government-callback-kgd"

  groups   = ["edi-government-callback-kgd"]
  consumes = [
    "GOVERNMENT_CALLBACK_KGD_CSV",
  ]
  produces = [
    "GOVERNMENT_CALLBACK_KGD_CSV",
  ]
}
