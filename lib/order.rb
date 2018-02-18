# Beginning WAVE 2 now.

require 'csv'
require 'awesome_print'

### Intial CSV reading test thing:
### first_test = process_order_csv(test_order)

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
####
####  Now, we have to put all these pieces we've figured out together, so that
####  a given line from our CSV turns into:
####        <1> An array, with:
####            [0] the ID
####            [1] a hash of product - price pairs
####

#### To figure out how to do this, let's go to  original single line of CSV:
####
#### First, I'll run our parsing program:

#all_orders_initial = CSV.parse(File.read('../support/orders.csv'))
#ap all_orders_initial
#puts all_orders_initial.inspect

####  Then, I'll paste in the first line of that from the terminal, just so
####  we have something to work with.

####  ["1", "Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9"]

####  First, I'll see if I can get the CSV row-array into an array consisting of
####     [0] -- ID
####     [1] -- An array with the product-price strings separated to make
####            individual array elements, in which each element is a string
####            consisting of an unseparated product-price pair.

# test_order = [
#   "1",
#   "Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9"
# ]
#
# def process_order_csv(raw_order_array)
#   processed_order = []
#   processed_order[0] = raw_order_array[0]
#   processed_order[1] = CSV.parse(raw_order_array[1], col_sep: ';')
#   return processed_order
# end
#
# first_test = process_order_csv(test_order)
#
# puts first_test.inspect
#
# ap first_test

####  On the first run of this, it nearly came out okay, but it added
####  an extra level of array.  According to Zo, this is because wehn you
####  call .parse, it prepares an array for everything to get read into.
####  so, I guess we'll just be splitting.  Oh, well.
#
#
# test_order = [
#   "1",
#   "Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9"
# ]
#
# def process_order_csv(raw_order_array)
#   processed_order = []
#   processed_order[0] = raw_order_array[0]
#   processed_order[1] = raw_order_array[1].split(";")
#   return processed_order
# end
#
# first_test = process_order_csv(test_order)
#
# puts first_test.inspect
#
# ap first_test

#### This turned out exactly as desired.
####
#### .inspect saw:
####
#### ["1", ["Slivered Almonds:22.88", "Wholewheat flour:1.93", "Grape Seed Oil:74.9"]]
####
#### and awesome_print saw:
####
#### [
####    [0] "1",
####    [1] [
####        [0] "Slivered Almonds:22.88",
####        [1] "Wholewheat flour:1.93",
####        [2] "Grape Seed Oil:74.9"
####    ]
#### ]
####
####  Now, I want to see about getting the elements within index[1] split.

#
#
# test_order = [
#   "1",
#   "Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9"
# ]
#
# def process_order_csv(raw_order_array)
#   processed_order = []
#   processed_order[0] = raw_order_array[0]
#   separated_products = raw_order_array[1].split(";")
#   product_price_array = []
#   separated_products.each do |product_with_price|
#     product_price_pair = product_with_price.split(":")
#     product_price_array << product_price_pair
#   end
#   processed_order[1] = product_price_array
#   return processed_order
# end
#
# first_test = process_order_csv(test_order)
#
# puts first_test.inspect
#
# ap first_test

#### And this worked just great!

#### Here's what .inspect saw:
#### ["1", [["Slivered Almonds", "22.88"], ["Wholewheat flour", "1.93"], ["Grape Seed Oil", "74.9"]]]
####
#### And here's what awesome_print saw:
####
#### [
####    [0] "1",
####    [1] [
####        [0] [
####            [0] "Slivered Almonds",
####            [1] "22.88"
####        ],
####        [1] [
####            [0] "Wholewheat flour",
####            [1] "1.93"
####        ],
####        [2] [
####            [0] "Grape Seed Oil",
####            [1] "74.9"
####        ]
####    ]
#### ]
####
####  Now, we're ready to turn those 2-element arrays of price and product
####  into a hashes.
####
####

#
#
# test_order = [
#   "1",
#   "Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9"
# ]
#
# def process_order_csv(raw_order_array)
#   processed_order = []
#   processed_order[0] = raw_order_array[0]
#   separated_products = raw_order_array[1].split(";")
#   product_price_array = []
#   separated_products.each do |product_with_price|
#     product_price_pair = product_with_price.split(":")
#     product_price_array << product_price_pair
#   end
#   processed_order[1] = product_price_array.to_h
#   return processed_order
# end
#
# first_test = process_order_csv(test_order)
#
# puts first_test.inspect
#
# ap first_test

####  AAAAND that worked.
####
####  Here's what .inspect saw:
####
#### ["1", {"Slivered Almonds"=>"22.88", "Wholewheat flour"=>"1.93", "Grape Seed Oil"=>"74.9"}]
####
#### And here's what awesome_print saw:
#### [
####    [0] "1",
####    [1] {
####        "Slivered Almonds" => "22.88",
####        "Wholewheat flour" => "1.93",
####          "Grape Seed Oil" => "74.9"
####    }
####]

####  I do believe that is what we need.

####  Next steps:
####      A.  Get this method to iterate through the entire CSV
####      B.  1. Get the Order.new to take this as a singleton.
####          2. Get Order.new to take this sequantially.

####  Thinking that the best next step is B.1., because if Order.new won't
####  take this, we may have to modify it.

####  Ok. Tested fine with giving Order.new the outputs of this method as
####  first_test[0] and first_test[1]

####  Now, I think we're ready to start automating.
####  Sounds like commit o'clock again.

### SINGLE ROW TEST DATA:
##test_order = [
##  "1",
##  "Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9"
##]

all_orders_initial = CSV.parse(File.read('../support/orders.csv'))
ap all_orders_initial
puts all_orders_initial.inspect

#
#
#
# def process_order_csv(raw_order_array)
#   processed_order = []
#   processed_order[0] = raw_order_array[0]
#   separated_products = raw_order_array[1].split(";")
#   product_price_array = []
#   separated_products.each do |product_with_price|
#     product_price_pair = product_with_price.split(":")
#     product_price_array << product_price_pair
#   end
#   processed_order[1] = product_price_array.to_h
#   return processed_order
# end
#
#
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

##MISC STUFF FOR TESTING
#first_order = Grocery::Order.new(first_test[0], first_test[1])
##puts first_order.add_product("seagull", 12.50).inspect
#puts first_order.products.inspect
#puts first_order.id.inspect
#ap first_order
