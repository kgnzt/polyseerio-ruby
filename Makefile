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
	rspec ./test/unit
else
	rspec ./test/unit
endif

integration-test:
ifeq ($(BUILD_ENV),ci)
	rspec ./test/integration
else
	rspec ./test/integration
endif

validation-test:
ifeq ($(BUILD_ENV),ci)
	rspec ./test/validation
else
	rspec ./test/validation
endif

test: lint unit-test integration-test validation-test

.PHONY: install lint unit-test integration-test validation-test
