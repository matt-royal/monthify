require "month/version"
require "active_support/core_ext"
require "month/core_ext/object"

class Month
  include Comparable

  attr_reader :month, :year

  def self.current
    today = Date.current
    new(today.year, today.month)
  end

  def self.containing(datish)
    Month.new(datish.year, datish.month)
  end

  def initialize(year, month)
    @year, @month = year, month
  end

  def first_day
    Date.new(year, month, 1)
  end

  def last_day
    first_day.end_of_month
  end

  def first_moment
    first_day.beginning_of_day
  end

  def last_moment
    last_day.end_of_day
  end

  def previous
    self - 1.month
  end

  def next
    self + 1.month
  end

  def date_range
    Range.new(first_day, last_day)
  end

  def time_range
    Range.new(first_moment, last_moment)
  end

  def contains?(datish)
    date = datish.to_date
    year == date.year && month == date.month
  end

  def +(duration)
    Month.containing(first_day + duration)
  end

  def -(duration)
    Month.containing(first_day - duration)
  end

  def <=>(other)
    if year == other.year
      month <=> other.month
    else
      year <=> other.year
    end
  end

  def hash
    [self.class, year, month].hash
  end

  def to_s
    "%d/%02d" % [year, month]
  end
end

module Kernel
  def Month(convertee)
    if convertee.is_a?(Month)
      convertee
    elsif convertee.respond_to?(:to_date)
      Month.containing(convertee.to_date)
    else
      raise ArgumentError, "Don't know how to convert #{convertee.inspect} to Month"
    end
  end
end
