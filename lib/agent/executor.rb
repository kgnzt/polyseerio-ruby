require 'concurrent'
require 'helper'
require 'agent/handler/index'
require 'agent/helper'
require 'agent/default_config'

module Polyseerio
  module Agent
    # Agent executor functions.
    module Executor
      # Setsup a client's agent.
      def self.setup(client, options = {}) # rubocop:disable all
        options = Polyseerio::Helper.defaults(options, DEFAULT_CONFIG)

        Concurrent::Promise.new do
          if options[:attach]
            name = Helper.resolve_name(options)

            # fallback create
            instance = client.Instance.find_by_name(name)
                             .then(proc do |reason|
                               if reason.http_code == 404
                                 return client.Instance.create(name: name)
                               end
                             end).execute.value

            handler_options = options.select do |key, _|
              Polyseerio::Agent::Handler::HANDLER.key? key
            end

            dork = Helper.filter_handlers handler_options

            if dork.key? :event
              # setup_handler('event', client)
            end

            if dork.key? :process
              # setup_handler('process', client)
            end

            if dork.key? :metric
              # setup_handler('metric', client)
            end

            if dork.key? :fact
              # setup_handler('fact', client)
            end

            if dork.key? :expectation
              # setup_handler('expectation', client)
            end

            instance.attach.execute.value

            instance
          end
        end
      end

      # Tearsdown a client's agent.
      def self.teardown(client, instance)
        Concurrent::Promise.new do
          teardown_handler('event', client)

          instance.detach.excecute.value
        end
      end
    end
  end
end
