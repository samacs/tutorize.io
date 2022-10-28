module ThemeManagement
  extend ActiveSupport::Concern

  included do
    include ThemeHelper

    before_action :use_global_theme
    before_action :use_current_theme
    before_action :use_current_backend_theme
  end

  protected

  def use_global_theme
    prepend_view_path "#{themes_path}/global"
    prepend_view_path "#{themes_path}/global/components"
  end

  def use_current_theme
    prepend_view_path current_theme_path
    prepend_view_path "#{current_theme_path}/components"
  end

  def use_current_backend_theme
    prepend_view_path current_backend_theme_path
    prepend_view_path "#{current_backend_theme_path}/components"
  end

  def use_current_theme_mailers
    prepend_view_path "#{current_theme_path}/mailers"
  end

  def use_current_backend_theme_mailers
    prepend_view_path "#{current_backend_theme_path}/mailers"
  end

  def use_global_mailers
    prepend_view_path "#{themes_path}/global/mailers"
  end
end
