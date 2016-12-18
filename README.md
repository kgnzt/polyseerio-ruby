![Alt text](/asset/polyseerio_sdk_ruby.png?raw=true "Polyseer.io SDK for Ruby.")

# Polyseer.io SDK for Ruby

The official Polyseer.io SDK for Ruby. Detailed API information can be found at (https://polyseer.io/documentation).

## Requirements
  - Ruby
  - gem

## Installation

To install, run:

    gem install polyseerio

To add to your project Gemfile, insert:

    gem 'polyseerio'

## Example

Examples are available in /example

## Environment Variables

Certain values can be set in environment variables:

  * POLYSEERIO_TOKEN access-token used for API calls
  * RAILS_ENV        the current environment

## Usage

The SDK provides an agent that allows for immediate integration as well as
direct platform interactions.

Example: (Quick start)

    include 'polyseerio'

    client = Polyseerio.start
    client.instance.fact('foo', 'bar').execute.value

Example: (SDK)

    include 'polyseerio'

    client = Polyseerio.make
    client.Event.create(name: 'Testing').execute.value

## Design

All Polyseer.io SDK's make use of Promises for async calls. Promises allow for 
delaying and chaining async work.

  * Provides direct platform calls as well as a Polyseer.io Ruby agent.
  * All client SDK calls return a Concurrent::Promise.
  * Supports functional style programming.
  * Supports object-oriented style programming.
    * ORM style instances. E.g. environment.save(), alert.trigger();
  * A resources environment can be deduced or explicitly passed to SDK calls through the options param.
  * API calls made using the https:// protocol.

## Example

Examples are available in /example

## SDK Resources

Use of the SDK starts with the creation of a client. To construct a client 
instance, you may call either Polyseerio.start or Polyseerio.make. Once a
client has been created you may use any of its resources.

### Polyseerio

  * Polyseerio
    * .`start(options = {}) ⇒ Polyseerio::Client`
      * Create a client and start an Agent.
      * `options (Hash)`
        - `:env`        environment variable that holds the current environment
        - `:token`      an api token
        - `:token_env`  if no token is provided, this environment variable will be checked
        - `:agent`      a hash that will be used when starting this client's agent
        - `:upsert_env` if an environment cannot be found it will be created
        - `:version`    api version to use
        - `:timeout`    integer containing number of ms to wait for server responses
        - `:deduce`     if the environment should be deduced when not supplied
    * .`make(options = {}) ⇒ Polyseerio::Client`
      * Create a client.
      * `options (Hash)` see Polyseerio.start options.
    * `::Enum`
      * `.Color`
      * `.Determiner`
      * `.Direction`
      * `.Icon`
      * `.Icon`
      * `.Strategy`
      * `.Subtype`
      * `.Type`

### Polyseerio::Client

  * client
    * `.current_environment ⇒ client.Environment`
      * Resolves the current environment **IF** it has been deduced.
    * `.start_agent(options = {}) ⇒ Polyseerio::Client`  
      * Starts the Polyseer.io agent. Will use passed options or config.agent from client construction.
    * `.Alert`
    * `.Channel`
    * `.Environment`
    * `.Event`
    * `.Expectation`
    * `.Instance`
    * `.LogicBlock`
    * `.Member`
    * `.Settings`
    * `.Task`
    
### Alert

  * .Alert
    * `.create(attributes = {}, options = {})`
    * `.find(query = {}, options = {})`
    * `.find_by_id(id, options = {})`
    * `.find_by_name(name, options = {})`
    * `.new(attributes = {}) ⇒ client.Alert`
      * `.remove()`
      * `.save()`
      * `.trigger(payload = {})`
    * `.remove(id, options = {})`
    * `.trigger(id, payload, options = {})`
    * `.update(id, updates, options = {})`

### Channel

  * .Channel
    * `.create(attributes = {}, options = {})`
    * `.find(query = {}, options = {})`
    * `.find_by_id(id, options = {})`
    * `.find_by_name(name, options = {})`
    * `.message(id, content, options = {})`
    * `.new(attributes = {}) ⇒ client.Channel`
      * `.message(content)`
      * `.remove()`
      * `.save()`
    * `.remove(id, options = {})`
    * `.update(id, updates, options = {})`

### Environment

  * .Environment
    * `.create(attributes = {}, options = {})`
    * `.find(query = {}, options = {})`
    * `.find_by_id(id, options = {})`
    * `.find_by_name(name, options = {})`
    * `.message(id, content, options = {})`
    * `.new(attributes = {}) ⇒ client.Environment`
      * `.message(content)`
      * `.remove()`
      * `.save()`
    * `.remove(id, options = {})`
    * `.update(id, payload = {}, options = {})`

### Event

  * .Event
    * `.create(attributes = {}, options = {})`
    * `.find(query = {}, options = {})`
    * `.find_by_id(id, options = {})`
    * `.new(attributes = {}) ⇒ client.Event`
      * `.save()`

### Expectation

  * .Expectation
    * `.check(id, options = {})`
    * `.create(attributes = {}, options = {})`
    * `.find(query = {}, options = {})`
    * `.find_by_id(id, options = {})`
    * `.find_by_name(name, options = {})`
    * `.new(attributes = {}) ⇒ client.Expectation`
      * `.check()`
      * `.remove()`
      * `.save()`
    * `.remove(id, options = {})`
    * `.update(id, updates, options = {})`

### Instance

  * .Instance
    * `.attach(options = {})`
    * `.create(attributes = {}, options = {})`
    * `.find(query = {}, options = {})`
    * `.find_by_id(id, options = {})`
    * `.find_by_name(name, options = {})`
    * `.new(attributes = {}) ⇒ client.Instance`
      * `.add_fact(key, resolver)`
        * Add a fact to the attach monitoring loop.
        * `key (symbol)`
        * `resolver (string|number|block)`
      * `.add_gauge(key, resolver)`
        * Add a gauge to the attach monitoring loop.
        * `key (symbol)`
        * `resolver (string|number|block)`
      * `.attach()`
        * Start inbound monitoring.
      * `.detach()`
        * Terminate inbound monitoring.
      * `.fact(key, value)`
        * Send a one-off fact.
      * `.gauge(key, value)`
        * Send a one-off gauge metric.
      * `.remove()`
      * `.save()`
    * `.remove(id, options = {})`
    * `.update(id, updates, options = {})`

### Logic Block

  * .LogicBlock
    * `.create(attributes = {}, options = {})`
    * `.execute(id, options = {})`
    * `.find(query = {}, options = {})`
    * `.find_by_id(id, options = {})`
    * `.find_by_name(name, options = {})`
    * `.new(attributes = {}) ⇒ client.LogicBlock`
      * `.execute()`
      * `.remove()`
      * `.save()`
    * `.remove(id, options = {})`
    * `.update(id, updates, options = {})`

### Member

  * .Member
    * `.create(attributes = {}, options = {})`
    * `.find(query = {}, options = {})`
    * `.find_by_id(id, options = {})`
    * `.new(attributes = {}) ⇒ client.Member`
      * `.remove()`
      * `.save()`
    * `.remove(id, options = {})`
    * `.update(id, updates, options = {})`

### Settings

  * .Settings
    * `.retrieve()`
    * `.update(updates, options = {})`

### Task

  * .Task
    * `.create(attributes = {}, options = {})`
    * `.find(query = {}, options = {})`
    * `.find_by_id(id, options = {})`
    * `.new(attributes = {}) ⇒ client.Task`
      * `.remove()`
      * `.save()`
    * `.remove(id, options = {})`
    * `.update(id, updates = {}, options = {})`

## Building

To test, build, and install locally:

    make

To build and install:

    make build

## Testing

Testing requires:

  - Make

Install gems locally by running:

    make install

Then run a command below based on what test suite you need to run.

### Lint

    make lint

### Unit

    make unit-test

### Integration

    make integration-test

### Validation

Requires the environment to have a root level access-token defined as:

    export POLYSEERIO_TOKEN=a-test-root-key

    make validation-test

### All

    make test
