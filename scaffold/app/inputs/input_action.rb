class InputAction < Formtastic::Actions::InputAction
  def to_html
    button_html[:class] ||= ''
    classes = ' md-button'
    builder.submit(text, button_html.merge(class: classes))
  end
end
