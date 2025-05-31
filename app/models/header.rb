class Header < ApplicationRecord
  include NameSequenciable

  scope :enabled, -> { where(enabled: true) }

  belongs_to :response

  def self.create_default(response_id: nil)
    new_header = Header.new
    new_header.field = next_titleized_name(:field, response_id: response_id)
    new_header.value = "value"
    new_header.response_id = response_id
    new_header.enabled = true
    new_header
  end
end
