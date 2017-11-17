module SimpleForm
  module Helpers
    # autofocus module
    module Autofocus
      private

      def has_autofocus?
        options[:autofocus] == true
      end
    end
  end
end
