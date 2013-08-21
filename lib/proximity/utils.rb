module Proximity
  module Utils
    extend self

    def source_and_target(hash)
      hash.to_a.first
    end
    
    def stringify_keys!(hash)
      hash.keys.each { |key| hash[key.to_s] = hash.delete(key) }
    end
  end
end
