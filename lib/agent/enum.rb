module Polyseerio
  module Agent
    module Enum
      module Expectation
        IS_ALIVE = 'is_alive'.freeze
      end

      module Event
        START = 'start'.freeze
        STOP  = 'stop'.freeze
      end

      module Signal
        SIGHUP  = 'HUP'.freeze
        SIGINT  = 'INT'.freeze
        SIGTERM = 'TERM'.freeze
      end

      module Process
        EXIT = 'exit'.freeze
      end

      module Metric
        MEMORY = 'memory'.freeze
      end
    end
  end
end
