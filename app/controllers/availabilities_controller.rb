class AvailabilitiesController < ApplicationController
  before_action :require_teacher
  before_action :set_availability, only: %i[edit update destroy]

  decorates_assigned :availability

  def new
    @availability = current_user.availabilities.new(weekday: params[:weekday], date: params[:date])
  end

  def edit; end

  def create
    @availability = current_user.availabilities.new(availability_params)
    respond_to do |format|
      if @availability.save
        format.turbo_stream
        format.html { redirect_to profile_path, success: 'Availability created successfully' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @availability.update(availability_params)
        format.turbo_stream
        format.html { redirect_to profile_path, success: 'Availability updated successfully' }
      else
        format.html do
          render :new, status
          :unprocessable_entity
        end
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @availability.destroy
      format.turbo_stream
      format.html { redirect_to profile_path, success: 'Availability deleted successfully' }
    end
  end

  private

  def availability_params
    params.require(:availability).permit(:weekday, :date, :from, :to, :available)
  end

  def availability_params_parsed_times
    params_hash = availability_params.to_h
    %i[from to].each do |param|
      parts = (1..5).map { |n| params_hash["#{param}(#{n}i)"] }
      (1..5).each { |n| params_hash.delete "#{param}(#{n}i)" }
      date = parts[0..2].join('-')
      time = parts[3..4].join(':')
      params_hash[param] = Time.zone.parse("#{date} #{time}")
    end
    params_hash
  end

  def set_availability
    @availability = current_user.availabilities.find(params[:id])
  end
end
