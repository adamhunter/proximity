$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'proximity'
require 'rack/proxy'
require 'pry'

class SpecProxy < Rack::Proxy
  include Proximity
end

def mock_routes
  Proximity::Router.new.tap { |router|
    router.draw do
      route 'example' => 'example.com/api' do
        proxy 'active'                                  => 'are/you/active'
        proxy 'count'                                   => same
        proxy 'accounts'                                => same, formats: %w[json csv]
        proxy 'accounts/:account_id'                    => same
        proxy 'accounts/:account_id/members/:member_id' => 'accounts-members/:account_id-:member_id'
      end
    end
  }
end


RSpec.configure do |config|
  config.order = :random
end
