# Топик для автозакрытия лидов ЮЛ в OCRM
# CDS рассчитывает когда необходимо закрыть лид
# Бизнес-владелец: ДМБ (Еникеева Д.)
# ИТ-владелец: УРСОО (Команда oCRM)
module "ocrm_lead_auto_close" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  name = "OCRM-LEAD-AUTO-CLOSE"

  # Optional parameters
  partitions  = 4     # Default 4
  replicate   = true # Default true
  retain_days = 1     # Default 1
}

# module "ocrm_lead_auto_close_app" {
#   source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"
# 
#   role = "ocrm_lead_auto_close"
#  
#   groups   = ["ocrm_lead_auto_close"]
#   produces = [module.ocrm_lead_auto_close.name]
#   consumes = [module.ocrm_lead_auto_close.name]
# }

# доступ по роли для нового сервиса по автолидам. 
module "ocrm_lead_auto_close_new_app" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"
 
  role = "di-leads-status"
  
  groups   = ["di-leads-status"]
  produces = [module.ocrm_lead_auto_close.name]
  consumes = [module.ocrm_lead_auto_close.name]
}


# Список доступов к топикам для группы ocrm
module "ocrm_access_list" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "ocrm"

  groups   = ["ocrm"]
  produces = ["OCRM-LEAD-AUTO-CLOSE"]
  consumes = ["OCRM-LEAD-AUTO-CLOSE"]
}
