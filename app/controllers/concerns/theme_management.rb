module ThemeManagement
  extend ActiveSupport::Concern

  included do
    include ThemeHelper

    before_action :use_global_theme

    helper_method :body_classes

    display_breadcrumbs!
  end

  class_methods do
    def add_body_classes(classes, **options)
      before_action -> { body_classes << classes }, options
    end

    def display_breadcrumbs(display: true, **options)
      before_action -> { display_breadcrumbs(display: display) }, options
    end

    def display_breadcrumbs!(**options)
      display_breadcrumbs(display: true, **options)
    end
  end

  protected

  def body_classes
    @body_classes ||= ["#{controller_name.dasherize}-controller", "#{action_name.dasherize}-action"]
  end

  def display_breadcrumbs(display: true)
    @should_display_breadcrumbs = display
  end

  def display_breadcrumbs?
    @should_display_breadcrumbs && true
  end

  def use_global_theme
    prepend_view_path "#{themes_path}/global"
    prepend_view_path "#{themes_path}/global/mailers"
  end

  def use_current_theme
    prepend_view_path current_theme_path
    prepend_view_path "#{current_theme_path}/mailers"
  end

  def use_current_backend_theme
    prepend_view_path current_backend_theme_path
    prepend_view_path "#{current_backend_theme_path}/mailers"
  end
end
