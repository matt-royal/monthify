require 'spec_helper'
require 'monthify'

describe Monthify::TimeRange do
  let(:first_moment) { Time.now }
  let(:last_moment) { first_moment + 90.days }
  let(:time_range) { described_class.new(first_moment, last_moment) }
  subject { time_range }

  describe '#initialize' do
    it 'requires two times' do
      expect { described_class.new }.to raise_error(ArgumentError)
      expect { described_class.new(Time.now) }.to raise_error(ArgumentError)
      expect { described_class.new(nil, nil) }.to raise_error(ArgumentError)
      expect { described_class.new(Object.new, Object.new) }.to raise_error(ArgumentError)
    end
  end

  it { should be_a(Range) }
  its(:first) { should == first_moment }
  its(:last) { should == last_moment }

  its(:first_moment) { should == first_moment }
  its(:last_moment) { should == last_moment }
  its(:first_day) { should == first_moment.to_date }
  its(:last_day) { should == last_moment.to_date }

  its(:date_range) { should == Range.new(first_moment.to_date, last_moment.to_date) }
  its(:dates) { should == time_range.date_range.to_a }

  describe "==" do
    let(:jan10) { Time.local(2012, 1, 10) }
    let(:jan15) { Time.local(2012, 1, 15) }
    let(:jan20) { Time.local(2012, 1, 20) }
    let(:jan10_to_jan20) { described_class.new(jan10, jan20) }
    let(:jan10_to_jan20_dup) { described_class.new(jan10, jan20) }
    let(:jan15_to_jan20) { described_class.new(jan15, jan20) }

    it 'is true for two copies of the same TimeRange' do
      jan10_to_jan20.should == jan10_to_jan20_dup
    end
    it 'is false for a different TimeRange' do
      jan10_to_jan20.should_not == jan15_to_jan20
    end
    it 'is false for a non-TimeRange' do
      jan10_to_jan20.should_not == Object.new
    end
  end

  describe "#hash" do
    let(:jan10) { Time.local(2012, 1, 10) }
    let(:jan15) { Time.local(2012, 1, 15) }
    let(:jan20) { Time.local(2012, 1, 20) }
    let(:jan10_to_jan20) { described_class.new(jan10, jan20) }
    let(:jan10_to_jan20_dup) { described_class.new(jan10, jan20) }
    let(:jan15_to_jan20) { described_class.new(jan15, jan20) }

    it 'is the same for two equal TimeRanges' do
      jan10_to_jan20.hash.should == jan10_to_jan20_dup.hash
    end

    it 'is different for two different TimeRanges' do
      jan10_to_jan20.hash.should_not == jan15_to_jan20.hash
    end
  end
end
