class StaticPagesController < ApplicationController
  skip_before_action :require_user

  before_action :render_not_found, unless: :page_exists?
  before_action :call_before_render_page

  def show
    render page_view
  end

  private

  def before_render_home
    display_breadcrumbs(display: false)
  end

  def page_view
    @page_view ||= [controller_name, page].join('/')
  end

  def page
    @page ||= params[:page]
  end

  def page_exists?
    lookup_context.template_exists?(page_view)
  end

  def render_not_found
    render 'static_pages/not_found', status: :not_found
  end

  def call_before_render_page
    callback = "before_render_#{page}"
    return unless respond_to?(callback, true)

    send(callback)
  end
end
