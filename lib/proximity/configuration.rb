module Proximity
  module Configuration

    def env
      ENV['PROXIMITY_ENV'] ||= ENV['RACK_ENV'] || 'development'
    end

    def engine
      ActionDispatch::Journey
    end

    def routesClass
      engine.const_get(:Routes)
    end

    def routerClass
      engine.const_get(:Router)
    end

    def pathPatternClass
      engine.const_get(:Path).const_get(:Pattern)
    end

  end
end

