module ApplicationHelper
  include TimeHelpers
  include Pagy::Frontend

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

  def render_role_dashboard(role_name)
    role_name = role_name.name if role_name.is_a?(Role)
    render role_name if lookup_context.exists?(role_name, ['dashboard'], true)
  end

  def render_role_sidebar(role_name)
    role_name = role_name.name if role_name.is_a?(Role)
    view_name = "layouts/#{role_name}_sidebar"
    render view_name if lookup_context.exists?(view_name, [], true)
  end

  def duration_select_options(maximum = Setting.maximum_lesson_duration)
    (0.25..maximum).step(0.25).map { |t| [time_from_decimal(t), t] }
  end
end
