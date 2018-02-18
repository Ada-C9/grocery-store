require './lib/order'

module Grocery
  class  OnlineOrder < Grocery::Order




  end

end
#generic_order = Grocery::Order.new(24, [apple: 5, orange:7 ])
#generic_order.first
#ap generic_order
#.first #=> "I'm a bird. Kah."

generic_O_order = Grocery::OnlineOrder.new(3, apple: 10, dates: 4)
#generic_O_order.first # => "I'm a bird. Kah."

ap generic_O_order
