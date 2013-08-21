# Proximity

`Proximity` is a [`Rack::Proxy`](https://github.com/ncr/rack-proxy) router that uses 
[`Journey`](https://github.com/rails/journey) for routing.  `Journey` is
vendored into `ActionPack` as of [`Rails`](https://github.com/rails/rails/tree/master/actionpack/lib/action_dispatch/journey)4.

[![Gem Version](https://badge.fury.io/rb/proximity.png)](http://badge.fury.io/rb/proximity)
[![Code Climate](https://codeclimate.com/github/adamhunter/proximity.png)](https://codeclimate.com/github/adamhunter/proximity)
[![Build Status](https://travis-ci.org/adamhunter/proximity.png?branch=master)](https://travis-ci.org/adamhunter/proximity)
[![Coverage Status](https://coveralls.io/repos/adamhunter/proximity/badge.png)](https://coveralls.io/r/adamhunter/proximity)
[![Dependency Status](https://gemnasium.com/adamhunter/proximity.png)](https://gemnasium.com/adamhunter/proximity)

## Usage
1. Create your own subclass of `Rack::Proxy`.
2. `include Proximity` into that class.
3. Define `rewrite_env` and `rewrite_response` as normal. `Proximity`
   overrides `Rack::Proxy`'s call so your `env['HTTP_HOST']` and
   `env['PATH_INFO']` will be changed before your call to `rewrite_env`.
4. If you override `call`, ensure you call super.
5. Create your proxy routes in a `proxies.rb` file and require it in your
   application.

## Example
```ruby
# my_proxy.rb
class MyProxy < Rack::Proxy
  include Proximity
end

# proxies.rb
MyProxy.routes.draw do
  route 'example' => 'example.com/api' do
    proxy 'active'                => 'accounts/active'
    proxy 'accounts'              => same, formats %w[json csv]
    proxy 'accounts/:account_id'  => same
    proxy 'crazy/:id/:account_id' => 'fluffy/kitties/:id-:account_id'
  end
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'proximity'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install proximity

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
