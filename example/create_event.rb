require 'polyseerio'
include Polyseerio::Enum

# Setup a client that sends resources to the development environment.
client = Polyseerio.make environment: 'development'

# Create an event to indicate success.
success_event = client.Event.create(
  name: 'Success',
  color: Color::GREEN,
  icon: Icon::CHECK
).execute.value

# Create a danger event promise.
emit_danger_event = client.Event.create(
  name: 'Danger, something is wrong.',
  color: Color::RED,
  icon: Icon::ERROR
)

# Execute the promise.
danger_event = emit_danger_event.execute.value

puts "Danger event #{danger_event.id} has been created."
puts "Event #{success_event.id} has been created."
