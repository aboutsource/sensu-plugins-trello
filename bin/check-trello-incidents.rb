#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Check for new incidents in Trello
#
# DESCRIPTION:
#   Checks for cards in a trello list. If cards are present, the check returns
#   CRITICAL, containing name and date of last activity of card. When more
#   than one card is present, all card names and dates are returned with ';'
#   delimiter.
#
# CONFIGURATION:
#   Configuration of API key and API token should be done through the sensu
#   settings file located in /etc/sensu/conf.d/.
#
#   'api_key' and 'api_token' can be obtained from Trello
#   (https://trello.com/app-key). 'list' can be obtained by adding .json
#   to a card in the browser in the list that should be monitored and search
#   for 'idList' in the JSON-output. Note that in a production environment,
#   api_key and api_token must be specified in the sensu settings rather than
#   through CLI parameters
#
# OUTPUT:
#   plain text
#
#
# USAGE:
#   Check if a specific trello list is empty or contains cards
#      ./check-trello-incidents.rb -k 123456789012 -t 1234567890121234567890 \
#         -l 1234567890

require 'sensu-plugin/check/cli'
require 'sensu-plugin/utils'
require 'json'
require 'yaml'
require 'net/http'

class CheckTrelloIncidents < Sensu::Plugin::Check::CLI
  include Sensu::Plugin::Utils

  option :host,
         description: 'Trello host address',
         short: '-h HOST',
         long: '--host HOST',
         default: 'api.trello.com'

  option :port,
         description: 'Trello port',
         short: '-p PORT',
         long: '--port PORT',
         default: 443

  option :list,
         description: 'Trello list to check',
         short: '-l LIST',
         long: '--list LIST'

  option :api_key,
         description: 'Trello API key',
         short: '-k KEY',
         long: '--api-key KEY'

  option :api_token,
         description: 'Trello API token',
         short: '-t TOKEN',
         long: '--api-token TOKEN'

  option :timeout,
         description: 'Trello request timeout in seconds',
         long: '--timeout TIMEOUT',
         default: 30

  def run
    host = config[:host]
    port = config[:port].to_i
    key =  config[:api_key] || settings['trello_incidents']['api']['key']
    token = config[:api_token] || settings['trello_incidents']['api']['token']
    list = config[:list]
    timeout = config[:timeout].to_i

    begin
      Timeout.timeout(timeout) do
        check_list(host, port, key, token, list)
      end
    rescue Timeout::Error
      unknown 'Connection timed out'
    end
  end

  def check_list(host, port, key, token, list)
    raise format('Invalid value for list parameter: %<list>s', list: list) if list.match(/\A[a-z0-9]*\z/).nil?

    path = format('/1/lists/%<list>s/cards', list: list)

    uri = URI.parse(format('https://%<host>s:%<port>d%<path>s',
                           host: host, port: port, path: path))
    params = { key: key, token: token }
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    res.value

    incidents = JSON.parse(res.body)

    if incidents.empty?
      ok 'No new incidents'
    else
      critical incidents.map { |incident| incident['name'] }.join('; ')
    end
  end
end
