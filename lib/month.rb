require "month/version"
require "active_support/core_ext"

class Month
  attr_reader :month, :year

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
end
