module SimpleForm
  module Inputs
    # Grouped Collection Select Input class
    class GroupedCollectionSelectInput < CollectionInput
      def input(wrapper_options = nil)
        label_method, value_method = detect_collection_methods

        merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

        @builder.grouped_collection_select(attribute_name, grouped_collection,
                      group_method, group_label_method, value_method, label_method,
                      input_options, merged_input_options)
      end

      private

      def grouped_collection
        @grouped_collection ||= begin
          gc = grouped_collection = options.delete(:collection)
          gc.respond_to?(:call) ? grouped_collection.call : grouped_collection.to_a
        end
      end

      # Sample collection
      def collection
        @collection ||= grouped_collection.map { |collection| collection.try(:send, group_method) }.detect(&:present?) || []
      end

      def group_method
        @group_method ||= options.delete(:group_method)
      end

      def group_label_method
        label = options.delete(:group_label_method)

        unless label
          common_method_for = detect_common_display_methods(detect_collection_classes(grouped_collection))
          label = common_method_for[:label]
        end

        label
      end

      def detect_method_from_class(collection_classes)
        return {} if collection_classes.empty?

        sample = collection_classes.first.instance_methods

        { label: SimpleForm.collection_label_methods.find { |method| sample.include?(method) },
          value: SimpleForm.collection_value_methods.find { |method| sample.include?(method) } }
      end
    end
  end
end
