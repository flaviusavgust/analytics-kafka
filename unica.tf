# Set of topics for Unica integrations
variable "unica_xls_topics" {
    type = set(string)
    description = "Unica XLS integration topics"
    default = [
      # XLS integration topics
      "UNICA_XLS_CLIENT_ATTRIBUTES_UPDATES",
      "UNICA_XLS_CLIENT_ATTRIBUTES_UPDATES_RESULTS",
      "UNICA_XLS_CAMPAIGN_CREATE",
      "UNICA_XLS_CAMPAIGN_CREATE_RESULTS",
      "UNICA_XLS_CAMPAIGN_SUBSCRIBE",
      "UNICA_XLS_CAMPAIGN_SUBSCRIBE_RESULTS",
      "UNICA_XLS_CAMPAIGN_UNSUBSCRIBE",
      "UNICA_XLS_CAMPAIGN_UNSUBSCRIBE_RESULTS",
    ]
}

# Set of topics for Unica consumable topics
locals {   
  unica_consumes_topics = [
    module.di_atm_marketing_topic_activity.name,
    module.di_atm_marketing_topic_offer_response.name,
    module.cbs_tarif_data_contact_topic.name,
    module.onlinebank_onlinecredit_msb_topic.name,
    "OWT_PIN_INCORRECT",
    "OWT_NOT_ENOUGH_MONEY",
    "OWT_UNDER_THE_LIMIT",
  ]
}

module "unica_xls_topics" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  for_each = var.unica_xls_topics

  name       = each.value
  replicate  = true
  partitions = 10
}

variable "unica_adaptive_topics" {
    type = set(string)
    description = "Unica Adaptive integration topics"
    default = [
      # Adaptive integration topics
      "unica-adaptive",
      "unica-adaptive-statuses",

      # Adaptive Internal
      "ADD_MILESTONE",
      "ADTECH_SEND",
      "ASYNC_DATABASE_INSERTS",
      "BATCH_IMPORT",
      "DATA_BATCH",
      "DATA_CLEAN",
      "DATA_FETCH",
      "DATA_MAP",
      "DATA_PAUSED",
      "DATA_RESUMED",
      "DECISION_SPLIT",
      "DELAY",
      "DELIVER_RESPONSES",
      "EMAIL_SEND",
      "END",
      "END_JOURNEY",
      "ENGAGEMENT_SPLIT",
      "INCOMING_RESPONSES",
      "JOIN",
      "JOURNEY_CONFIGURATION",
      "JOURNEY_CONTROL",
      "JOURNEY_ENGINE_MONITORING",
      "JOURNEY_EVENT",
      "JOURNEY_GOAL",
      "JOURNEY_GOAL_HANDLING",
      "JOURNEY_GOAL_VERIFICATION",
      "JOURNEY_MAP",
      "JOURNEY_PARSER",
      "JOURNEY_PAUSE",
      "JOURNEY_RESUME",
      "OUTGOING_MESSAGES",
      "PROCESS_MILESTONE",
      "PUBLISH_ACTION_POINT",
      "SALESFORCE_SEND",
      "SMS_SEND",
      "STREAMING_IMPORT",
      "kafkalog",
      "JOURNEY_OUTPUT",
      "LINK_OUTPUT",
    ]
}

variable "unica_adaptive_groups" {
    type = set(string)
    description = "Unica Adaptive integration groups"
    default = [
      "add-milestone-service-consumer-group",
      "adtech-service-consumer-group",
      "async-database-service-consumer-group",
      "batch-data-import-service-consumer-group",
      "data-batch-service-consumer-group",
      "data-clean-service-consumer-group",
      "data-map-service-consumer-group",
      "data-resume-service-consumer-group",
      "decision-split-service-consumer-group",
      "delay-service-consumer-group",
      "deliver-response-service-consumer-group",
      "email-service-consumer-group",
      "end-audience-service-consumer-group",
      "end-service-consumer-group",
      "engagement-split-service-consumer-group",
      "fetch-service-consumer-group",
      "join-service-consumer-group",
      "journey-configuration-service-consumer-group",
      "journey-control-consumer-group",
      "journey-goal-handling-consumer-group",
      "journey-goal-setting-consumer-group",
      "journey-goal-verification-consumer-group",
      "journey-mapping-service-consumer-group",
      "journey-pause-notifier-service-consumer-group",
      "journey-resume-service-consumer-group",
      "kafka-log-group",
      "orchestration-service-consumer-group",
      "parser-service-consumer-group",
      "paused-service-consumer-group",
      "process-milestone-service-consumer-group",
      "publish-action-point-consumer-group",
      "response-service-consumer-group",
      "salesforce-service-consumer-group",
      "sms-service-consumer-group",
      "stream-data-import-service-consumer-group",
      "journey-output-consumer-group",
      "link-output-consumer-group",
      "unica-adaptive-consumer-group",
      "unica-adaptive-statuses-consumer-group",
      "HCH-Consumer",
    ]
}

module "unica_adaptive_topics" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  for_each = var.unica_adaptive_topics

  name       = each.value
  replicate  = true
  partitions = 10
}

# Internal access
module "unica" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "unica"

  groups   = setunion(["unica", "unica-test-0", "unica-test-1", "unica-test-2", "unica-test-3", "unica-test-4", "unica-test-5"], var.unica_adaptive_groups)
  produces = setunion(var.unica_xls_topics, var.unica_adaptive_topics)
  consumes = setunion(var.unica_xls_topics, var.unica_adaptive_topics, var.golden_gate_topics, local.unica_consumes_topics)
}

module "di_unica_xls_sync" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "di-unica-xls-sync"

  groups   = ["di-unica-xls-sync"]
  produces = var.unica_xls_topics
  consumes = var.unica_xls_topics
}

module "adaptive" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "adaptive"

  groups   = setunion(["adaptive"], var.unica_adaptive_groups)
  produces = var.unica_adaptive_topics
  consumes = var.unica_adaptive_topics
}
