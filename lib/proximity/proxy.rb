module Proximity
  class Proxy
    attr_accessor :source, :target, :format

    def initialize(route_set)
      @route_set = route_set
    end

    def target
      with_format "#{route_set.target}#{slashify determine_target}"
    end

    def source
      with_format "#{route_set.source}#{slashify @source}"
    end

    def pattern
      Proximity.pathPatternClass.new(source)
    end

    def inspect
      "#<#{self.class.name} target=#{target} source=#{source}>"
    end

    private

    def slashify(path)
      return if path.blank?
      "/#{path}"
    end

    def with_format(url)
      format.nil? ? url : "#{url}.#{format}"
    end

    def determine_target
      @target == Same ? @source : @target
    end

    attr_reader :route_set

    Same = Class.new
  end
end
