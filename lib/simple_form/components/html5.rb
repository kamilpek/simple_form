module SimpleForm
  module Components
    # html5 component module
    module HTML5
      def initialize(*)
        @html_five = false
      end

      def html5(wrapper_options = nil)
        @html_five = true

        input_html_options[:required]        = input_html_required_option
        input_html_options[:'aria-required'] = input_html_aria_required_option

        input_html_options[:'aria-invalid']  = has_errors? || nil

        nil
      end

      def html5?
        @html_five
      end

      def input_html_required_option
        options[:required] ? required_field? : has_required?
      end

      def input_html_aria_required_option
        options[:required] ? (required_field? || nil) : (has_required? || nil)
      end

      def has_required?
        # We need to check browser_validations because
        # some browsers are still checking required even
        # if novalidate was given.
        required_field? && SimpleForm.browser_validations
      end
    end
  end
end
