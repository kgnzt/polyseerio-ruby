require 'enum'

# Default agent configuration.
module Polyseerio
  module Agent
    DEFAULT_CONFIG = {
      attach: true,
      attach_strategy: Polyseerio::Enum::Strategy::FALLBACK,
      token: nil,
      name: nil,
      description: 'Created by the Polyseer.io Ruby agent.',
      group: 'agent-created',
      environment: 'development',
      upsert_environment: false,
      env: 'NODE_ENV',
      direction: Polyseerio::Enum::Direction::INBOUND,
      subtype: Polyseerio::Enum::Subtype::LONG_RUNNING,
      heartbeats_till_death: nil,
      heartbeat_ttl: nil,
      on_start: [],
      on_error: [],
      on_exit: [],
      expectation: {
        is_alive: true
      },
      fact: {
        Enum::Fact::ENGINE => true,
        Enum::Fact::GID => true,
        Enum::Fact::LAUNCH_ARGUMENTS => true,
        Enum::Fact::PID => true,
        Enum::Fact::PLATFORM => true,
        Enum::Fact::RUBY_VERSION => true,
        Enum::Fact::UID => true
      },
      metric: {
        memory: true,
        cpu: true,
        uptime: true
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
    }.freeze
  end
end
