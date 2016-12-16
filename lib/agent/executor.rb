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

            # need a fallback create procedure
            instance = client.Instance.find_by_name(name)
                             .then(proc do |reason|
                               if reason.http_code == 404
                                 return client.Instance.create(name: name)
                               end
                             end).execute.value

            # now attach the client to the instance.
            # client.instance = instance // set it.

            # merge this with filter_handler below?
            handler_options = options.select do |key, _|
              Polyseerio::Agent::Handler::HANDLER.key? key
            end

            handler_options = Helper.filter_handlers handler_options

            # TODO: pass along ensure config, and client
            # setup_handler = Helper::setup_with_handler Handler::HANDLER, config, client
            setup_handler = Helper::setup_with_handler Handler::HANDLER

            # Gather the setups.
            setups = handler_options.map {|key, _config| setup(key) }

            Concurrent::Promise.zip(*setups).execute

            # now attach
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
