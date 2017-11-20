module SimpleForm
  module Components
    # Needs to be enabled in order to do automatic lookups.
    module Readonly
      def readonly(wrapper_options = nil)
        if readonly_attribute? && !has_readonly?
          input_html_options[:readonly] ||= true
          input_html_classes << :readonly
        end
        nil
      end

      private

      def readonly_attribute?
        object.class.readonly_attributes &&
          object.persisted?
      end
    end
  end
end
