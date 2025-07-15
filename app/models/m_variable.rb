class MVariable < ApplicationRecord
  belongs_to :variable_holder, polymorphic: true
end
