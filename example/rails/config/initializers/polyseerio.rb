require 'polyseerio'

# Add a Polyseerio initializer.
module Polyseerio
  class << self
    @polyseerio ||= Polyseerio.start(environment: 'testing').then(proc do |reason|
      puts reason
    end).execute.value

    def polyserio
      @polyseerio
    end
  end
end
