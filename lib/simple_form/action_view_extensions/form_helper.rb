module SimpleForm
  module ActionViewExtensions
    # This module creates SimpleForm wrappers around default form_for and fields_for.
    #
    # Example:
    #
    #   simple_form_for @user do |f|
    #     f.input :name, hint: 'My hint'
    #   end
    #
    module FormHelper

      def simple_form_for(record, options = {}, &block)
        options[:builder] ||= SimpleForm::FormBuilder
        html_options = options[:html] ||= {}
        unless html_options.key?(:novalidate)
          html_options[:novalidate] = !SimpleForm.browser_validations
        end
        if html_options.key?(:class)
          html_options[:class] = [SimpleForm.form_class, html_options[:class]].compact
        else
          html_options[:class] = [SimpleForm.form_class, SimpleForm.default_form_class, simple_form_css_class(record, options)].compact
        end

        with_simple_form_field_error_proc do
          form_for(record, options, &block)
        end
      end

      def simple_form_for_html

      end

      def simple_fields_for(record_name, record_object = nil, options = {}, &block)
        options, record_object = record_object, nil if record_object.is_a?(Hash) && record_object.extractable_options?
        options[:builder] ||= SimpleForm::FormBuilder

        with_simple_form_field_error_proc do
          fields_for(record_name, record_object, options, &block)
        end
      end

      private

      def with_simple_form_field_error_proc
        default_field_error_proc = ::ActionView::Base.field_error_proc
        begin
          ::ActionView::Base.field_error_proc = SimpleForm.field_error_proc
          yield
        ensure
          ::ActionView::Base.field_error_proc = default_field_error_proc
        end
      end

      def simple_form_css_class(record, options)
        html_options = options[:html]
        as = options[:as]

        if html_options.key?(:class)
          html_options[:class]
        elsif record.is_a?(String) || record.is_a?(Symbol)
          as || record
        else
          record = record.last if record.is_a?(Array)
          action = record.persisted? ? :edit : :new
          as ? "#{action}_#{as}" : dom_class(record, action)
        end
      end
    end
  end
end

ActiveSupport.on_load(:action_view) do
  include SimpleForm::ActionViewExtensions::FormHelper
end
