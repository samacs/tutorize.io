class BackendController < ApplicationController
  before_action :require_user
  before_action :use_current_backend_theme
end
