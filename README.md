# Sensu check for new incidents in Trello

Checks for cards in a trello list. If cards are present, the check returns
_CRITICAL_, containing name and date of last activity of card. When more than
one card is present, all card names and dates are returned with *;* delimiter.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sensu-plugins-trello'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sensu-plugins-trello

## CONFIGURATION
Configuration of API key and API token should be done through the sensu
settings file located in _/etc/sensu/conf.d/_. 
      
_api_key_ and _api_token_ can be obtained from
[Trello](https://trello.com/app-key). _list_ can be obtained by adding _.json_
to a card in the browser in the list that should be monitored and search for
_idList_ in the JSON-output. Note that in a production environment, _api_key_
and _api_token_ should be specified in the Sensu settings rather than through
CLI parameters.

## USAGE
Check if a specific trello list is empty or contains cards

### Required parameters

| Parameter | Description                         |
| --------- | ----------------------------------- |
| -l LIST   | id of the Trello list to be checked |
| -k KEY    | Trello API key                      |
| -t TOKEN  | Trello API token                    |

### Optional parameters

| Parameter          | Description                       |
| ------------------ | --------------------------------- |
| -h HOST            | Trello API host                   |
| -p PORT            | Trello API port                   |
| --timeout TIMEOUT  | Trello request timeout in seconds |

### Example:
```
 ./bin/check-trello-incidents.rb -k 123456789012 -t 1234567890121234567890 -l 1234567890
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can
also run `bin/console` for an interactive prompt that will allow you to
experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/aboutsource/sensu-plugins-trello.

