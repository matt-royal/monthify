require "month/version"
require "active_support/core_ext"

class Month
  include Comparable

  attr_reader :month, :year

  def self.current
    today = Date.current
    new(today.year, today.month)
  end

  def self.containing(dayish)
    Month.new(dayish.year, dayish.month)
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

  def first_second
    first_day.beginning_of_day
  end

  def last_second
    last_day.end_of_day
  end

  def previous
    self.class.containing(first_day - 1.day)
  end

  def next
    self.class.containing(last_day + 1.day)
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
