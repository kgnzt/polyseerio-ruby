require 'sdk/helper'

module Polyseerio
  # Contains handlers and handler map.
  module Handler
    HANDLER = Helper.dir_proc_map(File.dirname(__FILE__), self)
  end
end
