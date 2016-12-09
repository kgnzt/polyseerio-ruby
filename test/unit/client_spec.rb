require 'Client'

RSpec.describe Client do
  it 'raises an error without a cid' do
    expect { Client.new }.to raise_error(
      ArgumentError,
      /wrong number of arguments/
    )
  end

  #it 'raises an error if no request is passed' do
    #expect { Client.new(1, {}) }.to raise_error(
      #ArgumentError,
      #/Cannot create an instance of Client without/
    #)
  #end
end
