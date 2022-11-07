module CoverImageable
  extend ActiveSupport::Concern

  DEFAULT_COVER_IMAGE = 'default-course-cover-image.jpg'.freeze

  included do
    has_one_attached :cover_image do |attachable|
      attachable.variant :thumb, resize_to_limit: [120, 120]
      attachable.variant :normal, resize_to_limit: [620, 620]
      attachable.variant :list_item, resize_to_limit: [480, 480]
    end

    after_commit :set_default_image_cover, on: %i[create update]
  end

  private

  def set_default_image_cover
    return if cover_image.attached?

    cover_image.attach(io: Rails.root.join("app/assets/images/#{DEFAULT_COVER_IMAGE}").open,
                       filename: DEFAULT_COVER_IMAGE, content_type: 'image/jpg')
  end
end
