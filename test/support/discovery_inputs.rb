# String Input class
class StringInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options = nil)
    "<section>#{super}</section>".html_safe
  end
end

# Numeric Input class
class NumericInput < SimpleForm::Inputs::NumericInput
  def input(wrapper_options = nil)
    "<section>#{super}</section>".html_safe
  end
end

# Customized Input class
class CustomizedInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options = nil)
    "<section>#{super}</section>".html_safe
  end

  def input_method
    :text_field
  end
end

# Deprecated Input class
class DeprecatedInput < SimpleForm::Inputs::StringInput
  def input
    "<section>#{super}</section>".html_safe
  end

  def input_method
    :text_field
  end
end

# Collection Select Input test
class CollectionSelectInput < SimpleForm::Inputs::CollectionSelectInput
  def input_html_classes
    super.push('chosen')
  end
end

module CustomInputs
  # Customized Input class
  class CustomizedInput < SimpleForm::Inputs::StringInput
    def input_html_classes
      super.push('customized-namespace-custom-input')
    end
  end

  # Password Input class
  class PasswordInput < SimpleForm::Inputs::PasswordInput
    def input_html_classes
      super.push('password-custom-input')
    end
  end

  # Numeric Input class
  class NumericInput < SimpleForm::Inputs::PasswordInput
    def input_html_classes
      super.push('numeric-custom-input')
    end
  end
end
