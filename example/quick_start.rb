require 'polyseerio'

client = Polyseerio.make

result = client.Event.create(name: 'foo').execute.value

puts result
