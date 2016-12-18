module Polyseerio
  module Agent
    # Introduce metric handlers.
    module Handler
      def self.metric
        {
          Metric::MEMORY => proc do |_config, client|
            client.instance.add_gauge 'memory', 0
          end,

          Metric::CPU => proc do |_config, client|
            client.instance.add_gauge 'cpu_user', 0
            client.instance.add_gauge 'cpu_system', 0
          end,

          Metric::UPTIME => proc do |_config, client|
            client.instance.add_gauge 'uptime', 0
          end
        }
      end
    end
  end
end
