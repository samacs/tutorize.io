module ThemeManagement
  extend ActiveSupport::Concern

  included do
    helper_method :body_classes, :display_breadcrumbs?

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
end
