require 'uri'
require 'action_dispatch/journey'
require 'active_support/core_ext/string/starts_ends_with'

require "proximity/version"
require "proximity/configuration"

module Proximity
  extend Configuration

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def routes
      @routes ||= RouteSet.new
    end
  end

  def call(env)
    route_env(env)
    super
  rescue RoutingError => e
    headers = {'Content-Type' => 'text/plain', 'Content-Length' => e.message.length}
    [404, headers, [e.message]]
  end

  def route_env(env)
    host, path = route(env)
    env.tap { |e|
      e['SCRIPT_NAME']  = ''
      e['HTTP_HOST']    = host
      e['PATH_INFO']    = path
    }
  end

  def router
    self.class.routes.router
  end

  def route(env)
    match = router.match(env)

    if match
      uri = URI.parse(match.target)
      [uri.host, uri.path]
    else
      raise RoutingError.new("The path: #{env['PATH_INFO']} does not match any proxy routes.")
    end
  end

  RoutingError = Class.new(StandardError)
end

require "proximity/dsl"
require "proximity/proxy"
require "proximity/proxy_set"
require "proximity/router"
require "proximity/routes"
require "proximity/route_set"
require "proximity/utils"
