module Proximity
  class Proxy
    attr_accessor :source, :target, :format

    def initialize(route_set)
      @route_set = route_set
    end

    def target
      with_format "#{route_set.target}#{@target == Same ? @source : @target}"
    end

    def source
      with_format "#{route_set.source}#{@source}"
    end

    def pattern
      Proximity.pathPatternClass.new(source)
    end

    def inspect
      "#<#{self.class.name} target=#{target} source=#{source}>"
    end

    private

    def with_format(url)
      format.nil? ? url : "#{url}.#{format}"
    end

    attr_reader :route_set

    Same = Class.new
  end
end
