class ApplicationController < ActionController::Base
  include ThemeManagement
  include RedirectionManagement
  include SessionManagement

  helper_method :form_id, :generate_form_id, :display_breadcrumbs?

  add_flash_types :success, :error, :warning, :info

  protected

  def form_id
    @form_id ||= params[:form_id]
  end

  def generate_form_id(object = nil, suffix: nil, separator: '-', prefix: nil)
    for_object = helpers.dom_id(object) if object.present?

    [prefix, for_object, SecureRandom.uuid, suffix].compact.join(separator)
  end
end
