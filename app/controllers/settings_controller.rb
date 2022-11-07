class SettingsController < ApplicationController
  def edit; end

  def update
    preferences = preferences_params.reverse_merge(current_user.preferences)
    respond_to do |format|
      if current_user.update(preferences:)
        format.turbo_stream
        format.html { redirect_to settings_path }
        format.json { render json: current_user.preferences }
      else
        format.json { render json: current_user.errors, status: :unprocessable_entity }
        format.html { render :edit }
      end
    end
  end

  private

  def preferences_params
    params.require(:preferences).permit(:time_zone, :locale, :sidebar_open)
  end
end
