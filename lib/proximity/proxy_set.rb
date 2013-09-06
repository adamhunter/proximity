module Proximity
  class ProxySet
    include Dsl
    attr_accessor :route_set, :source, :target

    def self.default_scheme
      'http'
    end

    def initialize(route_set, source, target)
      self.route_set = route_set
      self.source    = source
      self.target    = target
    end

    def routes
      route_set.routes
    end

    module Scope
      def proxy(options)
        Utils.stringify_keys!(options)
        formats = options.delete('formats') || [options.delete('format')]

        formats.each do |format|
          set.routes.add_proxy set, *Utils.source_and_target(options), format
        end
      end

      def same
        Proxy::Same
      end
    end

    private

    def source=(value)
      @source = normalize_source(value)
    end

    def target=(value)
      @target = normalize_target(value)
    end

    def normalize_source(source)
      source.starts_with?('/') ? source : "/#{source}"
    end

    def normalize_target(target)
      uri = URI.parse(target)
      target = uri.scheme.nil? ? "#{self.class.default_scheme}://#{target}" : target
      env_tld target
    end

    def env_tld(url)
      %w[development test].include?(Proximity.env) ? url.sub('.com', '.local') : url
    end
  end
end
