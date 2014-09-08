module MIDIFX

  class Transpose

    attr_reader :factor, :name, :property

    def initialize(property, factor, options = {})
      @factor = factor
      @property = property
      @name = options[:name]
    end

    def process(message)
      val = message.send(@property)
      message.send("#{@property}=", val + @factor)
      message
    end

  end

end
