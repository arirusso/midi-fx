module MIDIFX

  class Limit

    attr_reader :limit_to, :name, :property
    alias_method :range, :limit_to

    def initialize(property, limit_to, options = {})
      @limit_to = limit_to
      @property = property
      @name = options[:name]
    end

    def process(message)
      val = message.send(@property)
      if @limit_to.kind_of?(Range)
        message.send("#{@property}=", @limit_to.min) if val < @limit_to.min
        message.send("#{@property}=", @limit_to.max) if val > @limit_to.max
      elsif @limit_to.kind_of?(Numeric)
        message.send("#{@property}=", @limit_to)
      end
      message
    end

  end

end
