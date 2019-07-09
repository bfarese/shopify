class ExceptionalValue
  attr_reader :reason

  def initialize(raw_value, reason: "Unspecified")
    @raw_value = raw_value
    @reason = reason
  end

  def exceptional?
    true
  end

  def to_s
    @raw_value.to_s
  end
end
