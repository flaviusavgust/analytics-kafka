export TF_VAR_kafka_role=${KAFKA_ROLE}
export TF_VAR_kafka_token=${KAFKA_TOKEN}

init-test:
	terraform init \
		-backend-config="address=http://gitlab.cloud.halykbank.nb/api/v4/projects/1165/terraform/state/test" \
		-backend-config="lock_address=http://gitlab.cloud.halykbank.nb/api/v4/projects/1165/terraform/state/test/lock" \
		-backend-config="unlock_address=http://gitlab.cloud.halykbank.nb/api/v4/projects/1165/terraform/state/test/lock" \
		-backend-config="username=${GITLAB_USERNAME}" \
		-backend-config="password=${GITLAB_TOKEN}" \
		-backend-config="lock_method=POST" \
		-backend-config="unlock_method=DELETE" \
		-backend-config="retry_wait_min=5"
	export TF_VAR_kafka_broker=analytics-test-kafka.service.almaty.consul:9092
	
init-prod:
	terraform init \
		-backend-config="address=http://gitlab.cloud.halykbank.nb/api/v4/projects/1165/terraform/state/production" \
		-backend-config="lock_address=http://gitlab.cloud.halykbank.nb/api/v4/projects/1165/terraform/state/production/lock" \
		-backend-config="unlock_address=http://gitlab.cloud.halykbank.nb/api/v4/projects/1165/terraform/state/production/lock" \
		-backend-config="username=${GITLAB_USERNAME}" \
		-backend-config="password=${GITLAB_TOKEN}" \
		-backend-config="lock_method=POST" \
		-backend-config="unlock_method=DELETE" \
		-backend-config="retry_wait_min=5"
	export TF_VAR_kafka_broker=analytics-kafka.service.almaty.consul:9092

plan:
	terraform plan -lock=false
