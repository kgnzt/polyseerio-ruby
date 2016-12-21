module Polyseerio
  module Agent
    # Introduce fact handlers.
    module Handler
      def self.fact
        {
          Fact::ENGINE => proc do |_config, client|
            client.instance.set_fact('engine', RUBY_ENGINE)
          end,

          Fact::GID => proc do |_config, client|
            client.instance.set_fact('gid', ::Process.gid)
          end,

          Fact::LAUNCH_ARGUMENTS => proc do |_config, client|
            value = ARGV.join('')

            client.instance.set_fact('launch_arguments', value)
          end,

          Fact::PID => proc do |_config, client|
            client.instance.set_fact('pid', ::Process.pid)
          end,

          Fact::PLATFORM => proc do |_config, client|
            client.instance.set_fact('platform', RUBY_PLATFORM)
          end,

          Fact::RUBY_VERSION => proc do |_config, client|
            client.instance.set_fact('ruby_version', RUBY_VERSION)
          end,

          Fact::UID => proc do |_config, client|
            client.instance.set_fact('uid', ::Process.uid)
          end
        }
      end
    end
  end
end
