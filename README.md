# DynamicTaggedLogger

Allows to specify log_tags as

    config.log_tags = [ lambda{|req| lambda{Time.now.strftime('%Y-%m-%d %H:%M:%S.%3N')} }, :uuid ]    

in order to obtain log records like this:
    
    Started GET "/" with uuid [233f049956a60138093b9a4a7412d838] for 127.0.0.1 at 2012-10-27 14:19:50 +0400
    [2012-10-27 14:19:51.315] [233f049956a60138093b9a4a7412d838] Processing by HomeController#show as HTML
    ...
    [2012-10-27 14:19:53.013] [233f049956a60138093b9a4a7412d838] Completed 200 OK in 1698ms (Views: 365.5ms | ActiveRecord: 134.0ms)



## Installation

Add this line to your application's Gemfile:

    gem 'dynamic_tagged_logger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dynamic_tagged_logger

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
