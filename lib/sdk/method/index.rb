require 'sdk/helper'

module Polyseerio
  module SDK
    # Intance methods.
    module Method
      MAP = Polyseerio::Helper.dir_proc_map(File.dirname(__FILE__), self)
    end
  end
end
