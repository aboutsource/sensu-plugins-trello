require 'webmock/rspec'

require_relative './plugin_stub.rb'
require_relative '../bin/check-trello-incidents.rb'

describe CheckTrelloIncidents do
  it 'should run' do
    stub_request(
      :get,
      'https://api.trello.com//1/lists/abcde/cards/?key=12345&token=12345'
    ).to_return(body: '[]', status: 200)

    check = CheckTrelloIncidents.new
    check.config[:api_key] = '12345'
    check.config[:api_token] = '12345'
    check.config[:list] = 'abcde'

    expect(check).to receive(:output).with('No new incidents')
    expect(-> { check.run }).to raise_error SystemExit
  end
end
