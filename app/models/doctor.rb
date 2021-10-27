class Doctor < ApplicationRecord
    has_many :appointments, dependent: :destroy
    has_many :patients, through: :appointments

    validates :name, presence: true
    validates :phone, presence: true
    validates :school, presence: true
    
end
