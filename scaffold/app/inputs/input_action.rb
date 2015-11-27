class InputAction < Formtastic::Actions::InputAction
  def to_html
    classes = button_html[:class].to_s + custom_classes
    builder.submit(text, button_html.merge(class: classes))
  end

  def custom_classes
    classes = [
      :primary,
      :warn,
      :raised,
      :fab,
      :mini,
    ]
    .select { |c| options[c] }
    .map { |c| "md-#{c}" }

    classes << 'md-button'

    ' ' + classes.join(' ')
  end
end
