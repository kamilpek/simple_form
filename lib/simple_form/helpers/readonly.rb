module SimpleForm
  module Helpers
    # readonly module
    module Readonly
      private

      def readonly_class
        :readonly if has_readonly?
      end

      def has_readonly?
        options[:readonly] == true
      end
    end
  end
end
