require "active_support/core_ext"

module Monthify
  class Month < TimeRange
    include Comparable

    #@return [Month] the current month
    def self.current
      today = Date.current
      new(today.year, today.month)
    end

    #@return [Month] the month after the current month
    def self.next
      current.next
    end

    #@return [Month] the month before the current month
    def self.previous
      current.previous
    end

    #@param [Date, Time, #to_date] datish
    #@return [Month] the month containing the given date
    def self.containing(datish)
      Month.new(datish.year, datish.month)
    end

    # Used by ActiveRecord::Base.serialize
    #@param [String] date_yaml the YAML for a date in the month
    #@return [Month]
    def self.load(date_yaml)
      date = YAML.load(date_yaml)
      Month.containing(date)
    end

    # Used by ActiveRecord::Base.serialize
    #@param [Month] month
    #@return [String] the YAML for the first date of the month
    def self.dump(month)
      YAML.dump(month.first_day)
    end

    #@param [Integer] year the number of the year
    #@param [Integer] month the number of the month
    #@return [Month]
    def initialize(year, month)
      first_moment = Date.new(year, month, 1).to_time.beginning_of_month
      last_moment = first_moment.end_of_month
      super(first_moment, last_moment)
    end

    def year
      first_day.year
    end

    def month
      first_day.month
    end

    #@return [Month] the month preceeding this one
    def previous
      self - 1.month
    end

    #@return [Month] the month following this one
    def next
      self + 1.month
    end
    alias :succ :next

    #@return [Range<Time, Time>] the range of time in this month
    def time_range
      self
    end

    #@param [Date, Time, #to_date] datish
    #@return [Boolean] true if the month contains the date, false otherwise
    def contains?(datish)
      date = datish.to_date
      year == date.year && month == date.month
    end

    # Adds the duration to the month
    #@param [ActiveSupport::Duration] duration
    #@return [Month]
    def +(duration)
      Month.containing(first_day + duration)
    end

    # Subtracts the duration from the month
    #@param [ActiveSupport::Duration] duration
    #@return [Month]
    def -(duration)
      Month.containing(first_day - duration)
    end

    #@!visibility private
    def <=>(other)
      if year == other.year
        month <=> other.month
      else
        year <=> other.year
      end
    end

    #@!visibility private
    def to_s
      "%d/%02d" % [year, month]
    end
    alias :inspect :to_s
  end
end

module ::Kernel
  # Globally accessible method to convert an argument into a Month.
  # If the argument cannot be converted, it raises an ArgumentError
  #@param [Month, #to_date] object_to_convert the object to convert to a Month
  #@return [Month] the given Month or the Month containing the given date
  def Month(object_to_convert)
    if object_to_convert.is_a?(Month)
      object_to_convert
    elsif object_to_convert.respond_to?(:to_date)
      Month.containing(object_to_convert.to_date)
    else
      raise ArgumentError, "Don't know how to convert #{object_to_convert.inspect} to Month"
    end
  end
end
