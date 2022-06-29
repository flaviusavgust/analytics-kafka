# Kafka - Топики и Доступы

Настройки топиков и доступов к ним в Apache Kafka CDO.

## Подключение

Для подключения используется механизм SASL_PLAIN. TLS подключение должно быть отключено. Роль и токен в обоих средах одинаковые.

### Тестовая среда

Broker: analytics-test-kafka.service.almaty.consul:9092

### Боевая среда

Broker: analytics-kafka.service.almaty.consul:9092

## Создание топика

В файле системы

```hcl
# Описание топика, зачем он нужен
module "<Название ресурса>" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-topic.git"

  name = "<Название топика>"

  # Optional parameters
  partitions  = 1     # Default 4
  replicate   = false # Default true
  retain_days = 1     # Default 1
}
```

## Создание доступов к топику

В файле системы

```hcl
# Описание приложения, для чего оно нужно
module "<Название ресурса>" {
  source = "git::http://gitlab.cloud.halykbank.nb/terraform/kafka-application.git"

  role = "<Роль STS>"

  # Optional parameters, but atleast one should be set
  groups   = ["test-app-group"]
  consumes = [module.test_topic.name]
  produces = [module.test_topic.name]
}
```

## Подключение к кластеру

### Golang

```go
conf := sarama.NewConfig()
conf.Net.SASL.Enable = true
conf.Net.SASL.User = "<Роль в STS>"
conf.Net.SASL.Password = "<Токен в STS для роли>"
conf.Producer.Return.Errors = true
conf.Producer.Return.Successes = true
conf.Producer.RequiredAcks = sarama.WaitForAll
conf.Consumer.Return.Errors = true

c, err := sarama.NewClient([]string{"<Brokers>"}, conf)
if err != nil {
    log.Fatalf("failed to create client %v", err)
}
```

### СSharp

```csharp
var conf = new ConsumerConfig{ 
  BootstrapServers = "<Brokers>", 
  GroupId = "<Идентификатор Группы>",
  SaslUsername = "<Роль в STS>",
  SaslPassword = "<Токен в STS для роли>",
  AutoOffsetReset = AutoOffsetReset.Earliest,
  SocketTimeoutMs = 1000,
  EnableAutoCommit = false,
  EnableAutoOffsetStore = false,
  QueuedMinMessages = 1,
  SecurityProtocol = SecurityProtocol.SaslPlaintext,
  SaslMechanism = SaslMechanism.Plain
};
```

### Python

```python
import json

from confluent_kafka import DeserializingConsumer


def value_deserializer(message, meta):
    return json.loads(message)


conf = {
    "bootstrap.servers": "<Brokers>",
    "group.id": "<Идентификатор Группы>",
    "sasl.username": "<Роль в STS>",
    "sasl.password": "<Токен в STS для роли>",
    "enable.auto.commit": False,
    "auto.offset.reset": "earliest",
    "value.deserializer": value_deserializer,
    "sasl.mechanism": "PLAIN",
    "security.protocol": "SASL_PLAINTEXT"
}
consumer: DeserializingConsumer = DeserializingConsumer(conf)
topics = ["<Topic Names>"]
consumer.subscribe(topics)
```
