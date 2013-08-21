module Proximity
  class RouteSet
    attr_reader :router, :source, :target

    def self.default_scheme
      'http'
    end

    def initialize(router)
      @router = router
    end

    def routes
      router.routes
    end

    def proxy(options)
      Utils.stringify_keys!(options)
      formats = options.delete('formats') || [options.delete('format')]

      formats.each do |format|
        routes.add_proxy self, *Utils.source_and_target(options), format
      end
    end

    def same
      Proxy::Same
    end

    def source=(value)
      @source = normalize_source(value)
    end

    def target=(value)
      @target = normalize_target(value)
    end

    private

    def normalize_source(source)
      source = source.starts_with?('/') ? source : "/#{source}"
      source = source.ends_with?('/')   ? source : "#{source}/"
    end

    def normalize_target(target)
      uri = URI.parse(target)
      target = uri.scheme.nil? ? "#{self.class.default_scheme}://#{target}" : target
      env_tld target.ends_with?('/') ? target : "#{target}/"
    end

    def env_tld(url)
      %w[development test].include?(Proximity.env) ? url.sub('.com', '.local') : url
    end

  end
end
