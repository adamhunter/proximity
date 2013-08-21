module Proximity
  class Routes < Proximity.routesClass

    attr_reader :proxies

    def [](index)
      routes[index]
    end

    def add_proxy(router, source, target, format)
      proxy = Proxy.new(router)
      proxy.source = source
      proxy.target = target
      proxy.format = format

      route = add_route(app, proxy.pattern, {}, {})
      route.extend(proxy_attr_module)
      proxy.tap { |p| route.proxy = p }
    end

    def proxy_attr_module
      @proxy_attr_module ||= Module.new { attr_accessor :proxy }
    end

    private

    def app
      nil
    end 
  end
end
