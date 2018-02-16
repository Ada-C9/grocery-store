require 'csv'
require 'awesome_print'
require_relative 'order.rb'

FILE_NAME = 'support/online_order_spec.csv'


module  Grocery

  class OnlineOrder < Order
    attr_reader :id, :products





  end

end

new_online_order = OnlineOrder.new(434, {"product": 4.57, "apples": 3.56})

puts new_order
