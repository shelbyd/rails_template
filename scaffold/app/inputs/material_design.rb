module MaterialDesign
  def input_wrapping(&block)
    template.content_tag('md-input-container',
      [template.capture(&block), error_html, hint_html].join("\n").html_safe,
      wrapper_html_options
    )
  end
end
