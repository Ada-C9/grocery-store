require 'pry'
require 'csv'

def all
  orders = []
  CSV.read("support/orders.csv").each do |row|
    # row looks like ["123", "Eggs:3.00;Milk:4.50"]
    # let's tackle id first
    id_string = row[0]
    id = id_string.to_i
    # let's tackle the products
    products_string = row[1]
    products_array = products_string.split(";")
     # let's loop inside products_array
     products_hash = {}
     products_array.each do |product|
       product_pair = product.split(":")
       product_name = product_pair[0]
       product_price = product_pair[1].to_f
       # now we put it into a hash
       products_hash[product_name] = product_price
     end
     order = Order.new(id, products_hash)
     orders << order

  end
  return orders
end

all
