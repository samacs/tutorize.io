class Course < ApplicationRecord
  include FriendlyId
  include CoverImageable

  belongs_to :teacher, class_name: 'User', inverse_of: :courses

  has_many :lessons, dependent: :destroy, inverse_of: :course

  scope :newest, -> { order(created_at: :desc) }

  resourcify

  friendly_id :name

  has_rich_text :description

  validates :name,
            presence: true

  after_create :assign_owner!

  private

  def assign_owner!
    teacher.add_role :owner, self
  end
end
