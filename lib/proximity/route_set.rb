module Proximity
  class RouteSet
    include Dsl

    attr_accessor :router

    def initialize
      self.router = Router.new
    end

    def routes
      router.routes
    end

    def draw(&block)
      dsl_exec(&block)
    end
    
    def proxy_sets
      @proxy_sets ||= []
    end

    module Scope
      def route(prefixes, &block)
        source, target = Utils.source_and_target(prefixes)
        set.proxy_sets << ProxySet.new(set, source, target)
        set.proxy_sets.last.dsl_exec(&block)
      end
    end
  end
end
