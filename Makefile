BUILD_ENV?=development

all: install test build

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

build:
	gem build polyseerio.gemspec
	gem install polyseerio-0.0.0.gem

.PHONY: install lint unit-test integration-test validation-test build
