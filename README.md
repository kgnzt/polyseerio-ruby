![Alt text](/asset/polyseerio_sdk_ruby.png?raw=true "Polyseer.io SDK for Ruby.")

# Polyseer.io SDK for Ruby

The official Polyseer.io SDK for Ruby. Detailed API information can be found at (https://polyseer.io/documentation).

## Requirements
  - Ruby
  - gem

## Installation

To install, run:

    gem install polyseerio

For a project, add to your Gemfile:

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

Example: (Configured quick start)

    include 'polyseerio'

    client = Polyseerio.start(
      token: 'secret-token, 
      environment: 'production',
      env: 'RAILS_ENV',
      agent: {
        name: 'my-instance',
        group: 'instances',
        metric: {
          memory: true,
          cpu: false
        }
      }
    )

Example: (SDK)

    include 'polyseerio'

    client = Polyseerio.make

    event = client.Event.create(
      name: 'example-event', 
      color: Polyseerio::Enum::Color::RED
    ).execute.value

## Design

All Polyseer.io SDK's make use of Promises for async calls. Promises allow for 
delaying and chaining async work.

Example:

    get_event = client.Event.find_by_name('some-name')

    // do something else

    get_event.execute.then{ |event| puts event.name }

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

Use of the SDK begins with construction of a client. To construct a client 
instance, call the required polyseerio module with an access-token.

### polyseerio

  * polyseerio
    * .`start(options) ⇒ Polyseerio::Client` create a client and start a agent
      * `options`
        - `:env` environment variable that holds the current environment
        - `:token` an api token
        - `:token_env` if no token is provided, this environment variable will be checked
        - `:agent` a hash that will be used when starting this client's agent
        - `:upsert_env` if an environment cannot be found it will be created
        - `:version` api version to use
        - `:timeout` integer containing number of ms to wait for server responses
        - `:deduce` if the environment should be deduced when not supplied
    * .`make(options) ⇒ Polyseerio::Client` create a client
      * `options` see polyseerio.start options from above
    * `::Enum`
      * `.Color`
      * `.Determiner`
      * `.Direction`
      * `.Icon`
      * `.Icon`
      * `.Strategy`
      * `.Subtype`

### client

  * client
    * `.current_environment(options)`  Resolves the current environment **IF** it has been deduced.
    * `.start_agent(config)`           Starts the Polyseer.io agent. Will use passed config or config.agent from client construction.
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
    * `.create(attributes, options)`
    * `.find(query, options)`
    * `.find_by_id(id, options)`
    * `.find_by_name(name, options)`
    * `.remove(id, options)`
    * `.trigger(id, payload, options)`
    * `.update(id, updates, options)`
    * new **Alert**(attributes)
      * `.save()`
      * `.remove()`
      * `.trigger(payload)`

### Channel

  * .Channel
    * `.create(attributes, options)`
    * `.find(query, options)`
    * `.find_by_id(id, options)`
    * `.find_by_name(name, options)`
    * `.message(id, content, options)`
    * `.remove(id, options)`
    * `.update(id, updates, options)`
    * new **Channel**(attributes)
      * `.save()`
      * `.remove()`
      * `.message(content)`

### Environment

  * .Environment
    * `.create(attributes, options)`
    * `.find(query, options)`
    * `.find_by_id(id, options)`
    * `.find_by_name(name, options)`
    * `.message(id, content, options)`
    * `.remove(id, options)`
    * `.update(id, payload, options)`
    * new **Environment**(attributes)
      * `.save()`
      * `.remove()`
      * `.message(content)`

### Event

  * .Event
    * `.create(attributes, options)`
    * `.find(query, options)`
    * `.find_by_id(id, options)`
    * new **Event**(attributes)
      * `.save()`

### Expectation

  * .Expectation
    * `.check(id, options)`
    * `.create(attributes, options)`
    * `.find(query, options)`
    * `.find_by_id(id, options)`
    * `.find_by_name(name, options)`
    * `.remove(id, options)`
    * `.update(id, updates, options)`
    * new **Expectation**(attributes)
      * `.save()`
      * `.remove()`
      * `.check()`

### Instance

  * .Instance
    * `.attach(options)`
    * `.create(attributes, options)`
    * `.find(query, options)`
    * `.find_by_id(id, options)`
    * `.find_by_name(name, options)`
    * `.remove(id, options)`
    * `.update(id, updates, options)`
    * new **Instance**(attributes)
      * `.save()`
      * `.remove()`
      * `.attach()`

### Logic Block

  * .LogicBlock
    * `.create(attributes, options)`
    * `.execute(id, options)`
    * `.find(query, options)`
    * `.find_by_id(id, options)`
    * `.find_by_name(name, options)`
    * `.remove(id, options)`
    * `.update(id, updates, options)`
    * new **LogicBlock**(attributes)
      * `.save()`
      * `.remove()`
      * `.execute()`

### Member

  * .Member
    * `.create(attributes, options)`
    * `.find(query, options)`
    * `.find_by_id(id, options)`
    * `.remove(id, options)`
    * `.update(id, updates, options)`
    * new **Member**(attributes)
      * `.save()`
      * `.remove()`

### Settings

  * .Settings
    * `.retrieve(options)`
    * `.update(updates, options)`

### Task

  * .Task
    * `.create(attributes, options)`
    * `.find(query, options)`
    * `.find_by_id(id, options)`
    * `.remove(id, options)`
    * `.update(id, updates, options)`
    * new **Task**(attributes)
      * `.save()`
      * `.remove()`

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
