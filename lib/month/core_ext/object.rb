class Month
  module CoreExt
    module Object
      def to_month
        Kernel::Month(self)
      end
    end
  end
end

class ::Object
  include Month::CoreExt::Object
end
