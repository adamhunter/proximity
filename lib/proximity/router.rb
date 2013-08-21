module Proximity
  class Router

    def routes
      @routes ||= Routes.new
    end

    def match(env)
      matches = router.send :find_routes, env
      Match.new(matches).presence
    end

    def inspect
      "#<#{self.class.name}>"
    end

    private

    def router
      @router ||= Proximity.routerClass.new(routes, {})
    end

    class Match
      def initialize(matches)
        @matches = matches
        @match   = matches.first
      end

      def matches
        @match[1]
      end

      def target
        matches.inject(proxy.target) { |target, (key, value)|
          target.gsub(":#{key}", value)
        }
      end

      def proxy
        @match[2].proxy
      end

      def presence
        @matches.empty? ? nil : self
      end
    end
  end
end
