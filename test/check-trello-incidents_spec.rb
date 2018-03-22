require_relative './plugin_stub.rb'
require_relative '../bin/check-trello-incidents.rb'

describe CheckTrelloIncidents do
  it 'should run' do
    check = CheckTrelloIncidents.new
    check.config[:api_key] = '12345'
    check.config[:api_token] = '12345'
    check.config[:list] = 'abcde'
    expect(-> { check.run }).to raise_error Net::HTTPServerException
  end
end
