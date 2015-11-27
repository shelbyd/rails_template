class BooleanInput < Formtastic::Inputs::BooleanInput
  # include MaterialDesign

  def to_html
    template.content_tag(
      'md-checkbox',
      hidden_field_html << label_text,
      input_html_options.merge(
        'ng-true-value' => checked_value.to_json,
        'ng-false-value' => unchecked_value.to_json,
        'ng-model' => angular_variable_name,
        'aria-label' => label_text,
        'ng-init' => "#{angular_variable_name} = #{checked? ? checked_value.to_json : unchecked_value.to_json}",
      )
    )
  end

  def hidden_field_html
    template.hidden_field_tag(
      input_html_options[:name],
      nil,
      'value' => "{{#{angular_variable_name}}}",
      id: nil,
      disabled: input_html_options[:disabled]
    )
  end

  def angular_variable_name
    input_html_options[:name]
      .gsub('[', '.')
      .gsub(']', '')
  end
end
