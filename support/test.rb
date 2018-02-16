require 'csv'
require 'awesome_print'
#where are we going to be running it in the terminal?
#we're int he grocery store folder 
CSV.open("support/orders.csv", 'r').each do |line|
  puts line
end


# array_of_orders_data = CSV.read("orders.csv")
# ap array_of_orders_data
