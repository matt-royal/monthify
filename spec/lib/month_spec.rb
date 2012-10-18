require 'spec_helper'
require 'month'

describe Month do
  describe '.current' do
    it 'is the current month' do
      Month.current.month.should == Date.current.month
      Month.current.year.should == Date.current.year
    end
  end

  describe "#initialize" do
    it 'sets month and year' do
      Month.new(2012,1).month.should == 1
      Month.new(2012,1).year.should == 2012
    end
  end

  describe "#first_day" do
    it 'is the first day of the month' do
      Month.new(2011, 7).first_day.should == Date.new(2011, 7, 1)
    end
  end

  describe "#last_day" do
    it 'is the last day of the month' do
      Month.new(2011, 7).last_day.should == Date.new(2011, 7, 31)
      Month.new(2011, 2).last_day.should == Date.new(2011, 2, 28)
    end
  end


  describe "#first_second" do
    it 'is the time at the start of the first day of the month' do
      Month.new(2011, 7).first_second.should == Time.local(2011, 7, 1, 0, 0, 0, 0)
    end
  end

  describe "#last_second" do
    it 'is the time at the end of the last day of the month' do
      Month.new(2011, 7).last_second.usec.should == 999_999
      Month.new(2011, 7).last_second.should == Time.local(2011, 7, 31).end_of_day
    end
  end
end
