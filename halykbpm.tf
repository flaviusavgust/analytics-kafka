# Halyk BPM (Camunda) Экземпляры процессов
module "halyk_bpm_topic_act_hi_procinst" {
    source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

    name       = "halykbpm_db_bpm_history.public.act_hi_procinst"
    partitions = 4
    replicate  = true
}

# Halyk BPM (Camunda) История отработки этапов процесса
module "halyk_bpm_topic_act_hi_actinst" {
    source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

    name       = "halykbpm_db_bpm_history.public.act_hi_actinst"
    partitions = 40
    replicate  = true
}

# Halyk BPM (Camunda) Задачи сотрудников в процессах (user task)
module "halyk_bpm_topic_act_hi_taskinst" {
    source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

    name       = "halykbpm_db_bpm_history.public.act_hi_taskinst"
    partitions = 4
    replicate  = true
}

# Halyk BPM (Camunda) Переменные процессов (данные)
module "halyk_bpm_topic_act_hi_varinst" {
    source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

    name       = "halykbpm_db_bpm_history.public.act_hi_varinst"
    partitions = 40
    replicate  = true
}

# Halyk BPM (Camunda) Данные переменных процесса типа object или JSON. act_hi_taskinst ссылается на эти данные через поле bytearray_id
module "halyk_bpm_topic_act_ge_bytearray" {
    source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

    name       = "halykbpm_db_bpm_history.public.act_ge_bytearray"
    partitions = 40
    replicate  = true
}

# Halyk BPM (Camunda) Переменные процессов (данные)
module "halyk_bpm_topic_united_non_credit_info" {
    source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

    name       = "halykbpm-united-non-credit-info"
    partitions = 4
    replicate  = true
}

# Halyk BPM access
module "halyk_bpm" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "halykbpm"

  produces = [
    module.halyk_bpm_topic_act_hi_procinst.name,
    module.halyk_bpm_topic_act_hi_actinst.name,
    module.halyk_bpm_topic_act_hi_taskinst.name,
    module.halyk_bpm_topic_act_hi_varinst.name,
    module.halyk_bpm_topic_united_non_credit_info.name,
    module.halyk_bpm_topic_act_ge_bytearray.name,
  ]

  consumes = [
    module.halyk_bpm_topic_act_hi_procinst.name,
    module.halyk_bpm_topic_act_hi_actinst.name,
    module.halyk_bpm_topic_act_hi_taskinst.name,
    module.halyk_bpm_topic_act_hi_varinst.name,
    module.halyk_bpm_topic_united_non_credit_info.name,
    module.halyk_bpm_topic_act_ge_bytearray.name,
  ]
}

# edi access to halyk bpm
module "halyk_bpm_edi" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "edi-halykbpm"

  groups = ["ocdo-edi-antifrod"]

  consumes = [
    "halykbpm_db_bpm_history.public.act_hi_procinst",
    "halykbpm_db_bpm_history.public.act_hi_actinst",
    "halykbpm_db_bpm_history.public.act_hi_taskinst",
    "halykbpm_db_bpm_history.public.act_hi_varinst",
    "halykbpm_db_bpm_history.public.act_ge_bytearray",
    "halykbpm-united-non-credit-info"
  ]
}