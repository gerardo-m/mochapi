module Responseable
  extend ActiveSupport::Concern

  included do
    has_one :response, as: :responseable, touch: true
  end
end
