# Lru::Rb

This is a thread safe LRU cache that can be used for any particular caching needs. I have already included a simple thread safe blocking queue that I used for calculating cache hit ratios in my rake test.

TODO: add unit tests
TODO: add a btree index on the linked_list for faster seeks - right now it is O(n) :frowning:

## Installation

Add this line to your application's Gemfile:

    gem 'lru-rb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lru-rb

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/lru-rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
