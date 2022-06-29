# Set of topics populated by Golden Gate
variable "golden_gate_topics" {
    type = set(string)
    description = "Golden Gate extracted data"
    default = [
      # OCRM topics https://confluence.halykbank.kz/pages/viewpage.action?pageId=181338168
      "GG_OCRM_ACCOUNT",
      "GG_OCRM_ACCOUNTCOMMUNICATION",
      "GG_OCRM_ACTIVITY",
      "GG_OCRM_CALL",
      "GG_OCRM_CASE",
      "GG_OCRM_CONTACT",
      "GG_OCRM_CONTACTADDRESS",
      "GG_OCRM_CONTACTCOMMUNICATION",
      "GG_OCRM_CONTRACT",
      "GG_OCRM_EXTERNALBANKACCOUNT",
      "GG_OCRM_FINAPPLICATION",
      "GG_OCRM_LEAD",
      "GG_OCRM_QUEUE",
      "GG_OCRM_SYSADMINUNIT",
      "GG_OCRM_TSACCOUNTOTHERSYSTEMCODE",
      "GG_OCRM_TSCLIENTSERVICE",
      "GG_OCRM_TSCONTACTOTHERSYSTEMCODE",
      "GG_OCRM_TSDEBT",
      "GG_OCRM_TSOFFERACRM",
      "GG_OCRM_TSSALARYPROJECT",
      "GG_OCRM_Z_SOURCE_FL",
      "GG_OCRM_Z_SOURCE_JL",
      "GG_OCRM_Z_SOURCE_PBOUL",

      # OpenWay topics
      "OW-TRANSACTIONS-EXP",
      "OW-CLIENTS-EXP",
      "OW-CONTRACTS-EXP",
      "GG_WAY4_OWS_CARD_INFO",
      "GG_WAY4_OWS_CLIENT_ADDRES",
      "GG_WAY4_OWS_CS_STATUS_LOG",
      "GG_WAY4_OWS_FX_RATE",
      "GG_WAY4_OWS_M_TRANSACTION",
      "GG_WAY4_TRANS_COND_DTLS",
      
      # XLS Topics
      "GG_XLS_ADMIN_OWJ_XLS_TXN_PUSH_QUEUE",
      "GG_XLS_ADMIN_TC_TXN",
      "GG_XLS_ADMIN_TC_TXN_AMOUNT",
      "GG_XLS_ADMIN_TERMINAL",
      "GG_XLS_ADMIN_MD_MEDIA",
      "GG_XLS_ADMIN_MD_BUCKET_ATTRIBUTE",
    ]
}

# Golden gate replicated topic setup
module "golden_gate_topics" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  for_each = var.golden_gate_topics

  name       = each.value
  replicate  = true
  partitions = 30
}

# Golden Gate access to topics for produce
module "golden_gate_fbd" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "golden-gate-fbd"

  produces = var.golden_gate_topics
}
