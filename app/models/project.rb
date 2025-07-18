class Project < ApplicationRecord
  include NameSequenciable
  include VariableHolder
  has_many :endpoints, dependent: :destroy
  validates :name, :space_name, presence: true, uniqueness: true

  def self.create_default
    new_project = Project.new
    new_project.name = next_titleized_name(:name)
    space_name = new_project.name.gsub(" ", "_").downcase
    new_project.space_name = space_name
    new_project
  end
end
