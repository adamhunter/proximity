module Proximity
  module Dsl

    def dsl_exec(&block)
      scope.instance_exec(&block) if block_given?
    end

    def scope
      @scope ||= scopeClass.new(self)
    end

    def scopeClass
      scopeModule = self.class.const_get(:Scope)
      Class.new do
        include scopeModule
        attr_reader :set
        def initialize(set)
          @set = set
        end
      end
    end
  end
end
