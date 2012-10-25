module Monthify
  module CoreExt
    module Object
      # Converts the object to a month. Uses the same logic as Kernel::Month().
      # Raises an ArgumentError if the object cannot be converted.
      #@return [Month] the object converted to a Month
      def to_month
        ::Kernel::Month(self)
      end
    end
  end
end

class ::Object
  include Monthify::CoreExt::Object
end
