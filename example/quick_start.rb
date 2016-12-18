require 'polyseerio'

# Quick start.
#
# Expects RAILS_ENV environment variable to contain current environment.
# Expects POLYSEERIO_TOKEN environment variable to contain token.
client = Polyseerio.start.execute.value

puts client
