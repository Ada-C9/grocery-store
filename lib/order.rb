# Beginning WAVE 2 now.

require 'csv'
require 'awesome_print'


### READING THE CSV INTO AN INITAL DATA STRUCTURE


###Testing for ability to open external CSV in this file
###using .parse and the Class with .read:
#all_orders_initial = CSV.parse(File.read('../support/orders.csv'))
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

#test_string = "Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9"

#a_string = "Dan;34\nMaria;55"
#semicolon_test_array = CSV.parse(test_string, col_sep: ';')

#ap semicolon_test_array
#puts semicolon_test_array.inspect

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
####  Ok.  I did a commit.  Now, I'm going to eat something.  BRB!

####  Ok, as promised, I have come RB, and I am having 2 thoughts:
####    1.   I keep feeling like all the spaces are going to cause problems,
####         and I have just read about a string method called .squeeze
####         that might be able to help.
####
####    2.   I just read about the .split method, and it does, indeed, have
####         a way to split our stuff at the colon.  So party.
####
####
####  So the next thing to do is to feed in our array of strings and see if we
####  can split it using the .split method, and turn it into something useful.
####  I am hyperaware, here, or our raidly deepening data structure, and dealing
####  with that, methinks, is going to be a little fiddly.  Oh, well.
####  At least it doesn't involve live (but raidly deteroirating) insect
####  gonads. And Barbara throwing a giant, public fit. THIS IS BETTER.
####
####  Ok. Test time.

####  split_testing_array =
####        [
####    "Slivered Almonds:22.88",
####    "Wholewheat flour:1.93",
####    "Grape Seed Oil:74.9"
####      ]

#split_testing_array = ["Slivered Almonds:22.88", "Wholewheat flour:1.93", "Grape Seed Oil:74.9"]

#product_price_array = []
#split_testing_array.each do |product_w_price|
#   product_price_pair = product_w_price.split(':')
#   product_price_array << product_price_pair
#end

#puts product_price_array.inspect

#ap product_price_array

####  And, yup, this worked out great again!
####
####  Here's what awesome_print sees:
####
#### [
####    [0] [
####        [0] "Slivered Almonds",
####        [1] "22.88"
####    ],
####    [1] [
####        [0] "Wholewheat flour",
####        [1] "1.93"
####    ],
####    [2] [
####        [0] "Grape Seed Oil",
####        [1] "74.9"
####    ]
#### ]
####
####
#### And here's what .inspect sees:
####
#### [["Slivered Almonds", "22.88"], ["Wholewheat flour", "1.93"], ["Grape Seed Oil", "74.9"]]

#### Now, what we need to be able to do is turn these arrays-of-two-things into
#### key-value pairs.

#### Looking at the ruby docs, it appears that there is an array method,
#### called as .to_h, that I can call on the whole frakking output of the split
#### to turn it into key-value pairs. So, let's try it!!!! Wooo!!!

# split_n_hash_testing_array = ["Slivered Almonds:22.88", "Wholewheat flour:1.93", "Grape Seed Oil:74.9"]
#
# product_price_array = []
# split_n_hash_testing_array.each do |product_w_price|
#    product_price_pair = product_w_price.split(':')
#    product_price_array << product_price_pair
# end
#
# hopefully_hashed_product_price_pairs = product_price_array.to_h

#puts product_price_array.inspect
#ap product_price_array

# puts hopefully_hashed_product_price_pairs.inspect
#
# ap hopefully_hashed_product_price_pairs

#### And that worked, too!  Huzzah!

#### Here's what awesome_print saw:
####
#### {
####    "Slivered Almonds" => "22.88",
####    "Wholewheat flour" => "1.93",
####      "Grape Seed Oil" => "74.9"
#### }
####
#### and here's what .inspect saw:
####
#### {"Slivered Almonds"=>"22.88", "Wholewheat flour"=>"1.93", "Grape Seed Oil"=>"74.9"}
####
####  Now that we've gotten to the end of the structure we need to create,
####  we need to start working backwards.  (And hey, it's the end of something,
####  so let's COMMIT!)













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
