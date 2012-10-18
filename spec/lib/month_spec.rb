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

  describe "comparison" do
    let(:dec_2010) { Month.new(2010, 12) }
    let(:jan_2011) { Month.new(2011, 1) }
    let(:jan_2011_dup) { Month.new(2011, 1) }
    let(:feb_2011) { Month.new(2011, 2) }

    specify { jan_2011.should == jan_2011_dup }
    specify { jan_2011.should_not == feb_2011 }
    specify { jan_2011.should_not == Object.new }

    specify { (jan_2011 <=> jan_2011_dup).should == 0 }
    specify { (jan_2011 <=> dec_2010).should == 1 }
    specify { (jan_2011 <=> feb_2011).should == -1 }

    specify { jan_2011.should be > dec_2010 }
    specify { jan_2011.should be < feb_2011 }
  end

  describe "#hash" do
    it 'is the same for two equal months' do
      Month.new(2010, 3).hash.should == Month.new(2010, 3).hash
    end

    it 'is different for two different months' do
      Month.new(2010, 3).hash.should_not == Month.new(2000, 1).hash
    end
  end
end
