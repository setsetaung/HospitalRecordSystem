class Patient < ApplicationRecord
    has_many :appointments, dependent: :destroy
    has_many :doctors, through: :appointments

    has_many :notes, dependent: :destroy
    has_many :users, through: :notes

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :dob, presence: true
    validates :phone, presence: true
    validates :street, presence: true
    validates :city, presence: true
    validates :zip, presence: true

    def full_name
        "#{self.first_name} #{self.last_name}"
    end
end


