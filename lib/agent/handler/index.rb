require 'sdk/helper'

module Polyseerio
  module Agent
    # Contains handlers and handler map.
    module Handler
      HANDLER = Polyseerio::Helper.dir_proc_map(File.dirname(__FILE__), self)
    end
  end
end
