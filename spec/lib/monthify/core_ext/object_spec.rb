require 'spec_helper'
require 'monthify'


describe Monthify::CoreExt::Object do
  it 'is included in Object' do
    Object.should be_a(Monthify::CoreExt::Object)
  end
end

describe ::Object do
  describe "#to_month" do
    it 'returns the result of Kernel::Month()' do
      receiver = ::Object.new
      result = double(:result)

      ::Kernel.should_receive(:Month).with(receiver).
        and_return(result)
      receiver.to_month.should == result
    end
  end
end
