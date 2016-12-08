# Default agent configuration.
module DefaultConfig
  config = {
    attach: true,
    attach_strategy: Strategy::FALLBACK,
    token: nil,
    name: nil,
    description: 'Created by the Polyseer.io Ruby agent.',
    group: 'agent-created',
    environment: 'development',
    upsert_environment: false,
    env: 'NODE_ENV',
    direction: Direction::INBOUND,
    subtype: Subtype::LONG_RUNNING,
    heartbeats_till_death: nil,
    heartbeat_ttl: nil,
    on_start: [],
    on_error: [],
    on_exit: [],
    expectation: {
      is_alive: true
    },
    metric: {
      memory: true
    },
    event: {
      start: true
    },
    process_event: {
      exit: true,
      warning: true,
      uncaughtException: true,
      unhandledRejection: true
    },
    process_signal: {
      SIGHUP: true,
      SIGINT: true,
      SIGTERM: true
    }
  }
end
