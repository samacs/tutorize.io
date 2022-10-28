module ApplicationHelper
  def title(base_title: Setting.title, separator: ' | ', reverse: false)
    return tag.title base_title unless content_for?(:title)

    parts = [base_title, content_for(:title)]
    parts.reverse! if reverse

    tag.title parts.join(separator)
  end
end
