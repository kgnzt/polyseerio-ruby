require 'polyseerio'

client = Polyseerio.make environment: 'testing'

client.Event.create(name: 'foo').execute.value
