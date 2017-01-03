require 'polyseerio'

include Polyseerio::Enum

# First we will Create a client thats default behavior is to place resources 
# the development environment.
client = Polyseerio.make environment: 'development'

# Direct SDK calls always return a Promise.
#
# Promises can be chained together to create an operation and then executed.
# Be sure to handle the error cases of your promises correctly to avoid
# any unexpected behavior.
client.Event.create(
  name: 'Success, something went right.',
  color: Color::GREEN,
  icon: Icon::CHECK
).then do |event|
  puts "Success event #{event.id} has been created."
end.execute.rescue do |error|
  puts "Something went wrong while creating a success event."
  puts error
end.value

# Like before we can create a promise.
#
# This time however, we will not execute the promise right away but rather
# defer it until a bit later.
emit_danger_event = client.Event.create(
  name: 'Danger, something went wrong.',
  color: Color::RED,
  icon: Icon::ERROR
)

# do some work...

# Not let's execute the danger event promise.
danger_event = emit_danger_event.then do |event|
  puts "Danger event #{event.id} has been created."
end.execute.rescue do |error|
  puts "Something went wrong while creating a danger event."
  puts error
end.value
