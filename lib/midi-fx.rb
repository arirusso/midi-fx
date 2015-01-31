#
# midi-fx
#
# MIDI effects in Ruby
#
# (c)2011-2014 Ari Russo
# Apache 2.0 License
#

# libs
require "midi-message"

# classes
require "midi-fx/filter"
require "midi-fx/limit"
require "midi-fx/transpose"

module MIDIFX

  VERSION = "0.4.2"

  MAP = {
    :band_pass_filter => BandPassFilter,
    :band_reject_filter => BandRejectFilter,
    :filter => Filter,
    :high_pass_filter => HighPassFilter,
    :limit => Limit,
    :low_pass_filter => LowPassFilter,
    :notch_filter => NotchFilter,
    :transpose => Transpose
  }

  def self.method_missing(method, *args, &block)
    if MAP.keys.include?(method)
      message = args.shift
      MAP[method].new(*args).process(message, &block)
    else
      super
    end
  end

end
