# Proximity

`Proximity` is a [`Rack::Proxy`](https://github.com/ncr/rack-proxy) router that uses 
[`Journey`](https://github.com/rails/journey) for routing.  `Journey` is
vendored into `ActionPack` as of [`Rails`](https://github.com/rails/rails/tree/master/actionpack/lib/action_dispatch/journey)4.

## Usage
1. Create your own subclass of `Rack::Proxy`
2. `include Proximity` into that class
3. Define `rewrite_env` and `rewrite_response` as normal
4. If you override `call`, ensure you call super
5. Create your proxy routes in a `proxies.rb` file

## Example
```ruby
# my_proxy.rb
class MyProxy < RackProxy
  include Proximity
end

# proxies.rb
MyProxy.routes.draw do
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
