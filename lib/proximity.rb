require 'uri'
require 'action_dispatch/journey'
require 'active_support/core_ext/string/starts_ends_with'

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
