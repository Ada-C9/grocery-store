# Beginning WAVE 2 now.

require 'csv'
require 'awesome_print'


### READING THE CSV INTO AN INITAL DATA STRUCTURE


###Testing for ability to open external CSV in this file
###using .parse and the Class with .read:
all_orders_initial = CSV.parse(File.read('../support/orders.csv'))
#ap all_orders_initial
#puts all_orders_initial.inspect
###  This works fine.
###  It creates an array of arrays with the ID at the 0-index and all
###  the order info in a kind of messy blob at the 1-index.

####  CONVERTING THE INITIAL DATA STRUCTURE INTO SOMETHING THAT
####  THE --ORDERS-- CLASS CAN USE:

####  Now, we have to do something about the mess at the arrays'
####  1-index.  An example from the first entry:
####  1,Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9
####  or, as awesome_print sees it:
####
####  [
####    [ 0] [
####        [0] "1",
####        [1] "Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9"
####    ]
####
####  this has to be split so that the producs and prices become key-value
####  pairs contained within a hash.

####  What's interesting here is that the product entries are separated by
####  semi-colons, and there's a way of parsing a CSV that's like that and
####  converting it into an array of arrays, which I just read about on
####  this website :  https://www.sitepoint.com/guide-ruby-csv-library-part/
####  so I'm kind of curious about whether I can make that work here.

####  Gonna try it now.  Here goes:

test_string = "Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9"

#a_string = "Dan;34\nMaria;55"
semicolon_test_array = CSV.parse(test_string, col_sep: ';')

#ap semicolon_test_array
puts semicolon_test_array.inspect

####   AAAnd it turns out that it works pretty darned well!

####   So now, let's get the sample product to put in my notes:
####   awesome_print sees:
####
####   [
####    [0] [
####        [0] "Slivered Almonds:22.88",
####        [1] "Wholewheat flour:1.93",
####        [2] "Grape Seed Oil:74.9"
####    ]
#### ]
####  and .inspect sees:
####
####[["Slivered Almonds:22.88", "Wholewheat flour:1.93", "Grape Seed Oil:74.9"]]
####
####  So that's pretty great!  Now, we have strings that need to be turned into
####  key-value pairs right at the point where they are joined by semicolons.
####
####  I bet anything that this is where .split comes in.
####  I'm feeling like it's just about commit 0'clock, though. 







=begin
###manually selected CSC info fro first line of orders.csv:

1,Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9

=end


#
#
#
#
# module Grocery
#
#   class Order
#     attr_reader :id
#     attr_accessor :products
#
#     def initialize(id, products)
#       @id = id
#       @products = products
#     end
#     def self.all
#     end
#     def add_product(product, price)
#       before_count = @products.count
#       if !@products.include?(product)
#         @products = @products.merge(product => price)
#       end
#       before_count + 1 == @products.count
#     end
#     def remove_product(product)
#       before_count = @products.count
#       @products.delete(product)
#       before_count - 1 == @products.count
#     end
#     def total
#       sum = @products.values.inject(0, :+)
#       sum_with_tax = expected_total = sum + (sum * 0.075).round(2)
#       return sum_with_tax
#     end
#   end
# end
#

#first_order = Grocery::Order.new(1337, {})
#puts first_order.add_product("seagull", 12.50).inspect
#puts first_order.product.inspect

=begin
wave_2_manual_test_order = Grocery::Order.new(1, {"Slivered Almonds" => 22.88, "Wholewheat flour" => 1.93, "Grape Seed Oil" => 74.9})
puts wave_2_manual_test_order.inspect
=end
