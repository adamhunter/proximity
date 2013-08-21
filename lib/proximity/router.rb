module Proximity
  class Router

    def draw(&block)
      scope.instance_exec(&block)
    end

    def scope
      @scope ||= Class.new { include Scope }.new(self)
    end

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

    module Scope
      attr_accessor :router

      def initialize(router)
        self.router = router
      end

      def route(prefixes, &block)
        source, target = Utils.source_and_target(prefixes)
        route_set = RouteSet.new(router)
        route_set.source = source
        route_set.target = target
        route_set.instance_eval(&block) if block_given?
      end
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
