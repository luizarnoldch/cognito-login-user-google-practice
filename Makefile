TEMPLATE_FILE := templates/dev.yml
STACK_NAME := admin-bashboard

init:
	go mod init main
update:
	go mod tidy
snyk:
	./scripts/snyk-scan.sh
build:
	./scripts/build.sh
test:
	go test ./...
func:
	./scripts/func_test.sh
mock:
	mockery --all --output ./tests/mocks/
deploy:
	sam deploy --template-file $(TEMPLATE_FILE) --stack-name $(STACK_NAME) --capabilities CAPABILITY_NAMED_IAM --resolve-s3
destroy:
	aws cloudformation delete-stack --stack-name $(STACK_NAME)
