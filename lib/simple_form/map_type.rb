require 'active_support/core_ext/class/attribute'

module SimpleForm
  # map type module
  module MapType
    def self.extended(base)
      base.class_attribute :mappings
      base.mappings = {}
    end

    def map_type(*types)
      map_to = types.extract_options![:to]
      raise ArgumentError, "You need to give :to as option to map_type" unless map_to
      self.mappings = mappings.merge types.each_with_object({}) { |type, mapping| mapping[type] = map_to }
    end
  end
end
