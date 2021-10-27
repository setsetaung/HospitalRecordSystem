class Note < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :patient

  validates :message, presence: true
end
