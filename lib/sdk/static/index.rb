require 'sdk/helper'

module Polyseerio
  module SDK
    # Static methods.
    module Static
      MAP = Polyseerio::Helper.dir_proc_map(File.dirname(__FILE__), self)
    end
  end
end
