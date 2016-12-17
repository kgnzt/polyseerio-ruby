module Polyseerio
  module Agent
    # Introduce fact handlers.
    module Handler
      def self.fact
        {
          Fact::PID => proc do |_config, client|
            client.instance.set_fact('pid', ::Process.pid)
          end,

          Fact::GID => proc do |_config, client|
            client.instance.set_fact('gid', ::Process.gid)
          end
        }
      end
    end
  end
end
