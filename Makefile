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
	rspec ./spec/unit
else
	rspec ./spec/unit
endif

integration-test:
ifeq ($(BUILD_ENV),ci)
	rspec ./spec/integration
else
	rspec ./spec/integration
endif

validation-test:
ifeq ($(BUILD_ENV),ci)
	rspec ./spec/validation
else
	rspec ./spec/validation
endif

test: lint unit-test integration-test validation-test

build:
	rm -f polyseerio-*.gem
	gem build polyseerio.gemspec
	gem install polyseerio-*.gem

.PHONY: install lint unit-test integration-test validation-test build
