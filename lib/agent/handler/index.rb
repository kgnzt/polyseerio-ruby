require 'helper'

module Polyseerio
  module Agent
    # Contains handlers and handler map.
    module Handler
      MAP = Polyseerio::Helper.dir_proc_map(File.dirname(__FILE__), self)

      # Extracts handler type options from agent options.
      def self.extract_options(options)
        options.select { |key, _| MAP.key? key }
      end
    end
  end
end
