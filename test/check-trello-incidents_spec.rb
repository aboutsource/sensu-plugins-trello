require 'json'
require 'webmock/rspec'

require_relative './plugin_stub.rb'
require_relative '../bin/check-trello-incidents.rb'

describe CheckTrelloIncidents do
  before(:each) do
    @api = stub_request(
      :get,
      'https://api.trello.com//1/lists/abcde/cards/?key=12345&token=12345'
    )

    @check = CheckTrelloIncidents.new
    @check.config[:api_key] = '12345'
    @check.config[:api_token] = '12345'
    @check.config[:list] = 'abcde'

    allow(@check).to receive(:output)
  end

  it 'should run' do
    @api.to_return(body: '[]', status: 200)

    expect { @check.run }.to raise_error do |error|
      expect(error).to be_a SystemExit
      expect(error.status).to eq 0
    end
    expect(@check).to have_received(:output).with('No new incidents')
    expect(@api).to have_been_requested
  end

  it 'should be critical if trello cards' do
    cards = [{ id: '1a2b3c', name: 'foo' }, { id: '1x2y3z', name: 'bar' }]
    @api.to_return(body: JSON.generate(cards), status: 200)

    expect { @check.run }.to raise_error do |error|
      expect(error).to be_a SystemExit
      expect(error.status).to eq 2
    end
    expect(@check).to have_received(:output).with('foo; bar')
    expect(@api).to have_been_requested
  end
end
