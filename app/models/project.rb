class Project < ApplicationRecord
    has_many :endpoints, dependent: :destroy
    validates :name, :space_name, presence: true, uniqueness: true
end
