require 'polyseerio'

RSpec.describe Polyseerio do
  it 'pending' do
    client = Polyseerio.make

    p = client.Event.find_by_name 'ding-dong'

    p.execute
  end
end
