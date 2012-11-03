require 'active_support/core_ext'

module Monthify
  class TimeRange < Range
    def initialize(first_moment, last_moment)
      raise ArgumentError, "first_moment must be a Time" unless first_moment.is_a?(Time)
      raise ArgumentError, "last_moment must be a Time"  unless last_moment.is_a?(Time)
      super
    end

    alias :first_moment :first
    alias :last_moment :last

    #@return [Date] the first day in the range
    def first_day
      first_moment.to_date
    end

    #@return [Date] the last day in the range
    def last_day
      last_moment.to_date
    end

    def date_range
      Range.new(first_day, last_day)
    end

    def dates
      date_range.to_a
    end
  end
end
