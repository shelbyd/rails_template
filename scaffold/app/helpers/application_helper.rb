module ApplicationHelper
  def title(new_title = nil)
    if new_title.present?
      @page_title = new_title
    end

    @page_title
  end
end
