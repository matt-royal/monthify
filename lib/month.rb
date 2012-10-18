require "month/version"
require "active_support/core_ext"

class Month
  include Comparable

  attr_reader :month, :year

  def self.current
    today = Date.current
    new(today.year, today.month)
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
end
