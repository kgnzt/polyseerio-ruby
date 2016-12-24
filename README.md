![Alt text](/asset/polyseerio_sdk_ruby.png?raw=true "Polyseer.io SDK for Ruby.")

# Polyseer.io SDK for Ruby

The official Polyseer.io SDK for Ruby. Detailed API information can be found at (https://polyseer.io/documentation).

## About

Polyseer.io is an Integrated Development Platform that instantly
provides teams with the resources needed to build, support, and maintain world 
class software products.

## Requirements
  - Ruby
  - gem

## Installation

To install, run:

    gem install polyseerio

To add to your project Gemfile, insert:

    gem 'polyseerio'

## Example

Be sure to check out the examples in /example.

## Environment Variables

Certain values can be set in environment variables:

  * POLYSEERIO_TOKEN     access-token used for API calls
  * RAILS_ENV            the current environment
  * POLYSEERIO_LOG_LEVEL SDK logging level

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

Be sure to check out the examples in /example.

## SDK Resources

Use of the SDK starts with the creation of a client. To construct a client 
instance, you may call either Polyseerio.start or Polyseerio.make. Once a
client has been created you may use any of its resources.

### Polyseerio

  * Polyseerio
    * .`make(options = {}) ⇒ Polyseerio::Client`
      * Create a client.
      * `options (Hash)` see Polyseerio.start options.
        - `:deduce (Boolean)` if the environment should be deduced when not supplied
        - `:env (String)` environment variable that holds the current environment
        - `:timeout (Integer)` integer containing number of ms to wait for server responses
        - `:token (String)` an api token
        - `:token_env (String)` if no token is provided, this environment variable will be checked
        - `:upsert_env (Boolean)` if an environment cannot be found it will be created
        - `:version (String)` api version to use
    * .`start(options = {}) ⇒ Polyseerio::Client`
      * Create a client and start an Agent.
      * `options (Hash)`
        - `:agent (Hash)` agent options (see client.start_agent options)
    * `::Enum`
      * `::Color (Hash)` platform color values
      * `::Determiner (Hash)` expectation deteriner types
      * `::Direction (Hash)` instance direction types
      * `::Icon (Hash)` platform icon types
      * `::Protocol (Hash)` alert protocol types
      * `::Strategy (Hash)` instance attachment strategies
      * `::Subtype (Hash)` instance subtypes
      * `::Type (Hash)` resource types

### Polyseerio::Client

  * client
    * `.current_environment ⇒ client.Environment`
      * Resolves the current environment **IF** it has been deduced.
    * `.start_agent(options = {}) ⇒ Polyseerio::Client`  
      * Starts the Polyseer.io agent for this client.
      * `options`
        - `.attach (Boolean)`
        - `.attach_strategy (Symbol)`
        - `.name (String)` instance name (will be used as a unique id)
        - `.description (String)` a description of this instance
        - `.group (String)` what group this instance belongs to
        - `.direction (String)` the monitoring direction (inbound) // force this
        - `.subtype (Polyseerio::Enum::Subtype)` the instance subtype: periodic or long_running.
        - `.expectation` will be upserted for this instance
          - `.is_alive (Boolean)` create an expectation that this process is alive
        - `.fact`
          - `.engine (Boolean)` the current ruby engine
          - `.gid (Boolean)` the group if othe process is running under
          - `.launch_arguments (Boolean)` command used to launch the instance
          - `.pid (Boolean)` the id of the process
          - `.platform (Boolean)` the operating platform of
          - `.ruby_version (Boolean)` the version of ruby being used
          - `.uid (Boolean)` user id the process is running as
        - `.metric`
          - `.cpu (Boolean)` track user and system cpu usage
          - `.memory (Boolean)` track memory usage
          - `.uptime (Boolean)` track process uptime
        - `.event`
          - `.start (Boolean)` event notice when agent starts
          - `.stop (Boolean)` event notice when agent stops
        - `.process_event`
          - `.exit (Boolean)` event notice on process exit
    
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
