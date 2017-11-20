module SimpleForm
  module Components
    # Needs to be enabled in order to do automatic lookups.
    module Maxlength
      def maxlength(wrapper_options = nil)
        input_html_options[:maxlength] ||= maximum_length_from_validation || limit
        nil
      end

      private

      def maximum_length_from_validation
        maxlength = options[:maxlength]
        if maxlength.is_a?(String) || maxlength.is_a?(Integer)
          maxlength
        else
          length_validator = find_validator(:length)
          maximum_length_value_from(length_validator)
        end
      end

      # Use validation with tokenizer if version of Rails is less than 5,
      # if not validate without the tokenizer, if version is greater than Rails 4.
      def maximum_length_value_from(length_validator)
        lng_val = length_validator
        if lng_val
          lng_val.options[:is] || length_validator.options[:maximum]
        end
      end
    end
  end
end
