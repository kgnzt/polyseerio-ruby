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
else
endif

validation-test:
ifeq ($(BUILD_ENV),ci)
else
endif

test: lint unit-test integration-test validation-test

.PHONY: install lint unit-test integration-test validation-test
