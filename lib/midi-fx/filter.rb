module MIDIFX

  # Use the Filter superclass when you need a multi-band filter
  class Filter

    attr_reader :bandwidth, :property, :reject

    def initialize(property, bandwidth, options = {})
      @bandwidth = [bandwidth].flatten
      @property = property
      @reject = options[:reject] || false
      @name = options[:name]
    end

    def process(message)
      val = message.send(@property)
      result = @bandwidth.map do |bw| 
        case bw
        when Range then val >= bw.min && val <= bw.max ? message : nil
        when Numeric then val == bw ? message : nil
        end
      end
      result.include?(message) ^ @reject ? message : nil
    end

  end

  class LowPassFilter < Filter
    def initialize(prop, max, options = {})
      super(prop, (0..max), options)
    end
  end

  class HighPassFilter < Filter
    def initialize(prop, min, options = {})
      super(prop, (min..127), options)
    end
  end

  class BandPassFilter < Filter
    def initialize(prop, accept_range, options = {})
      options[:reject] = false
      super(prop, accept_range, options)
    end
  end

  class BandRejectFilter < Filter
    def initialize(prop, reject_range, options = {})
      options[:reject] = true
      super(prop, reject_range, options)
    end
  end
  NotchFilter = BandRejectFilter

end
