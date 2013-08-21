require 'uri'
require 'action_dispatch/journey'

require "proximity/version"
require "proximity/configuration"

module Proximity
  extend Configuration
end

require "proximity/proxy"
require "proximity/router"
require "proximity/routes"
require "proximity/route_set"
require "proximity/utils"
