![Alt text](/asset/polyseerio_sdk_ruby.png?raw=true "Polyseer.io SDK for Ruby.")

# Polyseer.io SDK for Ruby

The official Polyseer.io SDK for Ruby. Detailed API information can be found at (https://polyseer.io/documentation).

## Requirements
  - Ruby
  - gem

## Installation

To install inside a project, run:

    gem install polyseerio

## Usage

The SDK allows for direct platform interactions as well as the use of a 
configurable agent that allows for immediate integration.

Example: (SDK with Agent)

Example: (SDK)

## Design

All Polyseer.io SDK's make use of Promises for async calls. Promises allow for 
delaying and chaining async work.

Example:

    get_event = client.Event.findByName('some-name')

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

  * polyseerio(config)
    * `options`
      - `.env` environment variable holding current environment
      - `.token` environment variable holding current environment
      - `.token_env` if no token is provided this environment variable will be checked
      - `.agent` an object that will be used when starting the agent
      - `.upsert_env` if an environment cannot be found it will be created
      - `.version` api version to use
      - `.timeout` integer containing number of ms to wait for server responses
      - `.deduce` if the environment should be deduced if not supplied

### client

  * client
    * `.getCurrentEnvironment(options)`  Resolves the current environment **IF** it has been deduced.
    * `.startAgent(config)`              Starts the Polyseer.io agent. Will use passed config or config.agent from client construction.
    * `.Color`
    * `.Icon`
    * `.Strategy`
    
### Alert

  * .Alert
    * `.create(attributes, options)`
    * `.find(query, options)`
    * `.findById(id, options)`
    * `.findByName(name, options)`
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
    * `.findById(id, options)`
    * `.findByName(name, options)`
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
    * `.findById(id, options)`
    * `.findByName(name, options)`
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
    * `.findById(id, options)`
    * new **Event**(attributes)
      * `.save()`

### Expectation

  * .Expectation
    * `.check(id, options)`
    * `.create(attributes, options)`
    * `.find(query, options)`
    * `.findById(id, options)`
    * `.findByName(name, options)`
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
    * `.findById(id, options)`
    * `.findByName(name, options)`
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
    * `.findById(id, options)`
    * `.findByName(name, options)`
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
    * `.findById(id, options)`
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
    * `.findById(id, options)`
    * `.remove(id, options)`
    * `.update(id, updates, options)`
    * new **Task**(attributes)
      * `.save()`
      * `.remove()`

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

### All

    make test
