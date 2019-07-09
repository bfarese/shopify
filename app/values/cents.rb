module Cents
  class Cent < WholeValue
    attr_reader :value

    def self.[](value)
      self.new(value)
    end

    def initialize(value)
      @value = value
      freeze
    end

    def inspect
      "#{self.class} [#{value}]"
    end

    def to_s
      "#{'%.2f' % (value / 100.00)}"
    end

    def +(other)
      Cent[@value + other.value]
    end

    def <=>(other)
      other.is_a?(Cent) && @value <=> other.value
    end

    def *(multiplicand)
      Cent[multiplicand * @value]
    end

    alias_method :to_i, :value
    alias_method :eql?, :==
  end

  def Cent(raw_value)
    case raw_value
    when Integer
      Cent[raw_value]
    when Cent
      raw_value
    when String
      Cent[(raw_value.to_f * 100).to_i]
    else
      ExceptionalValue.new(
        raw_value,
        reason: "Can't make Cents from #{raw_value.inspect}")
    end
  end

  class BlankCent < Blank; end

  module_function :Cent
end
