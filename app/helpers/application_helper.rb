module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'RUNTEQ BOARD APP'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
