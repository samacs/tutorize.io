module ApplicationHelper
  FLASH_ALERT_CLASS = {
    success: 'alert-success',
    error: 'alert-danger',
    warning: 'alert-warning',
    info: 'alert-primary'
  }.freeze
  FLASH_ICON_CLASS = {
    success: 'bx-check-circle',
    error: 'bx-error-circle',
    warning: 'bx-error',
    info: 'bx-info-circle'
  }.freeze

  def title(base_title: Setting.title, separator: ' | ', reverse: false)
    return tag.title base_title unless content_for?(:title)

    parts = [base_title, content_for(:title)]
    parts.reverse! if reverse

    tag.title parts.join(separator)
  end

  def flash_alert_class(type)
    FLASH_ALERT_CLASS.fetch(type.to_sym, 'alert-secondary')
  end

  def flash_alert_icon(type)
    css_class = FLASH_ICON_CLASS.fetch(type.to_sym, 'bx-info-circle')
    tag.i class: "bx #{css_class} me-2 fs-3"
  end
end
