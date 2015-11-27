class BooleanInput < Formtastic::Inputs::BooleanInput
  # include MaterialDesign

  def to_html
    template.content_tag(
      'md-checkbox',
      hidden_field_html << label_text,
      input_html_options.merge(
        'ng-true-value' => checked_value,
        'ng-false-value' => unchecked_value,
        'ng-model' => angular_variable_name,
        'aria-label' => label_text,
      )
    )
  end

  def hidden_field_html
    template.hidden_field_tag(
      input_html_options[:name],
      nil,
      'ng-value' => "{{#{angular_variable_name}}}",
      id: nil,
      disabled: input_html_options[:disabled]
    )
  end

  def angular_variable_name
    input_html_options[:name]
  end
end
