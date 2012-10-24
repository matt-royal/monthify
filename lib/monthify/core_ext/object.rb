module Monthify
  module CoreExt
    module Object
      def to_month
        ::Kernel::Month(self)
      end
    end
  end
end

class ::Object
  include Monthify::CoreExt::Object
end
