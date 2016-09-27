BUILD_ENV?=development

all: install test

install:
	bundle install

lint:
ifeq ($(BUILD_ENV),ci)
	rubocop
else
	rubocop
endif

unit-test:
ifeq ($(BUILD_ENV),ci)
	rspec ./test
else
	rspec ./test
endif

integration-test:
ifeq ($(BUILD_ENV),ci)
	grunt mochaTest:integration_file
else
	grunt mochaTest:integration_stdout
endif

validation-test:
ifeq ($(BUILD_ENV),ci)
	grunt mochaTest:validation_file
else
	grunt mochaTest:validation_stdout
endif

test: lint unit-test integration-test validation-test

.PHONY: install lint unit-test integration-test validation-test
