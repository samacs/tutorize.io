module Sessionable
  extend ActiveSupport::Concern

  def sign_in!(ip = nil)
    update!(last_sign_in_ip: current_sign_in_ip,
            last_sign_in_at: current_sign_in_at,
            current_sign_in_ip: ip,
            current_sign_in_at: Time.zone.now,
            sign_in_count: sign_in_count + 1)
  end

  def sign_out!
    update!(last_sign_in_ip: current_sign_in_ip,
            last_sign_in_at: current_sign_in_at,
            current_sign_in_ip: nil,
            current_sign_in_at: nil)
  end
end
