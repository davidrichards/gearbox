module Gearbox
  class AttributeCollection
    def initialize(default={})
      raise ArgumentError, "Must provide a hash for the defaults" unless default.is_a?(Hash)
      @default = default
      @source = {}
    end
    
    def []=(key, hash)
      raise ArgumentError, "Must provide a hash for the value" unless hash.is_a?(Hash)
      @source[normalize_key(key)] = OpenStruct.new(@default.merge(hash))
    end
    
    def [](key)
      @source[normalize_key(key)]
    end
    
    private
      def normalize_key(obj)
        obj.to_s.downcase.gsub(/[^A-Za-z0-9_]+/, '_').gsub(/(_$)|(^_)/, '').to_sym
      end
    
  end
end