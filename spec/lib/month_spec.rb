require 'spec_helper'
require 'month'

describe Month do
  describe '.current' do
    it 'is the current month' do
      Month.current.month.should == Date.current.month
      Month.current.year.should == Date.current.year
    end
  end

  describe '.containing' do
    it 'returns the month containing the date' do
      Month.containing(Date.new(2011, 1, 15)).should == Month.new(2011, 1)
    end

    it 'returns the month containing the time' do
      Month.containing(Time.local(2012, 3, 15, 6, 9)).should == Month.new(2012, 3)
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


  describe "#first_moment" do
    it 'is the time at the start of the first day of the month' do
      Month.new(2011, 7).first_moment.should == Time.local(2011, 7, 1, 0, 0, 0, 0)
    end
  end

  describe "#last_moment" do
    it 'is the time at the end of the last day of the month' do
      Month.new(2011, 7).last_moment.usec.should == 999_999
      Month.new(2011, 7).last_moment.should == Time.local(2011, 7, 31).end_of_day
    end
  end

  describe "#next" do
    it 'is the next month' do
      Month.new(2011, 11).next.should == Month.new(2011, 12)
      Month.new(2011, 12).next.should == Month.new(2012, 1)
    end
  end

  describe "#previous" do
    it 'is the previous month' do
      Month.new(2011, 2).previous.should == Month.new(2011, 1)
      Month.new(2011, 1).previous.should == Month.new(2010, 12)
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

  describe "#to_s" do
    it 'is in the format YYYY/MM' do
      Month.new(2010, 2).to_s.should == '2010/02'
    end
  end

  describe "Kernel::Month()" do
    it 'returns Month objects unchanged' do
      month = Month.current
      Kernel::Month(month).should == month
      Kernel::Month(month).should eq month
    end

    it 'converts a date to its Month' do
      Kernel::Month(Date.current).should == Month.current
    end

    it 'converts a time to its Month' do
      Kernel::Month(Time.now).should == Month.current
    end

    it 'converts an object that has a date representation to the right Month' do
      datish = double(:datish, to_date: Date.new(2001, 4))
      Kernel::Month(datish).should == Month.new(2001, 4)
    end

    it 'raises for other inputs' do
      expect {
        pp Kernel::Month(0)
      }.to raise_exception(ArgumentError)

      expect {
        pp Kernel::Month(nil)
      }.to raise_exception(ArgumentError)
    end
  end
end
