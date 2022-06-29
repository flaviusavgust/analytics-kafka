# Set of topics populated by Golden Gate
variable "ow_transactions_topics" {
    type = set(string)
    description = "OW Transcations extracted data"
    default = [ 
      "OWT_PIN_INCORRECT",
      "OWT_NOT_ENOUGH_MONEY",
      "OWT_UNDER_THE_LIMIT",
      "OWT_CARD_CLOSED",
    ]
}

# Golden gate replicated topic setup
module "ow_transactions_topic_split" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  for_each = var.ow_transactions_topics

  name       = each.value
  replicate  = true
  partitions = 16
}

# Golden Gate access to topics for produce
module "ow_transactions_topics" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "di-ow-transactions-topic-split"
  
  groups = ["di-ow-transactions-topic-split"]
  
  produces = [
      "OWT_PIN_INCORRECT",
      "OWT_NOT_ENOUGH_MONEY",
      "OWT_UNDER_THE_LIMIT",
      "OWT_CARD_CLOSED",
    ]
  consumes  = [
    "OW-TRANSACTIONS-EXP", 
    "GG_WAY4_TRANS_COND_DTLS"
    ]

}
