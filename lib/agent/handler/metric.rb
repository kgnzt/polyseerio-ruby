module Polyseerio
  module Agent
    # Introduce metric handlers.
    module Handler
      def self.metric
        {
          Metric::MEMORY => proc do |_config, _client|
            client.instance.add_gauge 'memory' do
              0
            end
          end,

          Metric::CPU => proc do |_config, _client|
            client.instance.add_gauge 'cpu_user' do
              0
            end
            client.instance.add_gauge 'cpu_system' do
              0
            end
          end,

          Metric::UPTIME => proc do |_config, _client|
            client.instance.add_gauge 'uptime' do
              0
            end
          end
        }
      end
    end
  end
end
