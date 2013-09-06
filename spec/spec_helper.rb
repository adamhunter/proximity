$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'proximity'
require 'rack/proxy'
require 'pry'
require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start
Coveralls.wear!

class SpecProxy < Rack::Proxy
  include Proximity

  def self.routes
    mock_routes
  end
end

def mock_routes
  Proximity::RouteSet.new.tap { |r|
    r.draw do
      # self is RouteSet instance
      route 'example' => 'example.com/api' do
        # self is ProxySet instance
        proxy 'active'                                  => 'are/you/active'
        proxy 'count'                                   => same
        proxy 'accounts'                                => same, formats: %w[json csv]
        proxy 'accounts/:account_id'                    => same
        proxy 'accounts/:account_id/members/:member_id' => 'accounts-members/:account_id-:member_id'
        proxy ''                                        => same
      end
    end
  }
end


RSpec.configure do |config|
  config.order = :random
end
