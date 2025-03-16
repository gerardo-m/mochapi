class RememberedValue < ApplicationRecord
  belongs_to :value_interchangeable, polymorphic: true

  scope :with_control_attribute, ->(control_attribute) { where(control_attribute: control_attribute) }
end
