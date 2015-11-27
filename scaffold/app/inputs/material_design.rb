module MaterialDesign
  def input_wrapping(&block)
    template.content_tag('md-input-container',
      [template.capture(&block), error_html, hint_html].join("\n").html_safe,
      wrapper_html_options
    )
  end

  def error_html
    template.content_tag('div',
      errors
        .map { |e| template.content_tag('div', e.html_safe, 'ng-message' => true) }
        .join("\n").html_safe,
      'ng-messages' => true,
    )
  end
end
