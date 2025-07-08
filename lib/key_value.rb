class KeyValue
  attr_accessor :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end

  def key_and_value
    "#{key} - #{value}"
  end
end
