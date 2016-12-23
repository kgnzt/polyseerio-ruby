module Polyseerio
  module Agent
    module Enum
      module Expectation
        IS_ALIVE = :is_alive
      end

      module Event
        START = :start
        STOP  = :stop
      end

      module Fact
        ENGINE           = :engine
        GID              = :gid
        LAUNCH_ARGUMENTS = :launch_arguments
        PID              = :pid
        PLATFORM         = :platform
        RUBY_VERSION     = :ruby_version
        UID              = :uid
      end

      module Signal
        SIGHUP  = :HUP
        SIGINT  = :INT
        SIGTERM = :TERM
      end

      module Process
        EXIT = :exit
      end

      module Metric
        MEMORY = :memory
        CPU    = :cpu
        UPTIME = :uptime
      end
    end
  end
end
