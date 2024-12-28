class PlainResponse < ApplicationRecord
  include Responseable

  def solve
    { plain: content }
  end
end
