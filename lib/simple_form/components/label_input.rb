module SimpleForm
  module Components
    # label input component module
    module LabelInput
      extend ActiveSupport::Concern

      included do
        include SimpleForm::Components::Labels
      end

      def label_input(wrapper_options = nil)
        depr_component = deprecated_component(:input, wrapper_options)
        if options[:label] == false
          depr_component
        else
          deprecated_component(:label, wrapper_options) + depr_component
        end
      end

      private

      def deprecated_component(namespace, wrapper_options)
        if method(namespace).arity == 0
          ActiveSupport::Deprecation.warn(SimpleForm::CUSTOM_INPUT_DEPRECATION_WARN % { name: namespace })
          method(namespace).call
        else
          method(namespace).call(wrapper_options)
        end
      end
    end
  end
end
