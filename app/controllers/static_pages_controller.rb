class StaticPagesController < ApplicationController
  before_action :render_not_found, unless: :page_exists?

  def show
    render page_view
  end

  private

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
end
