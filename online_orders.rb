require "csv"
require "awesome_print"
require_relative "order"

ONLINE_ORDERS_CSV = "../support/online_orders.csv"
# You do not need to write this class at all. Your constructor for `OnlineOrder`
# should take and store a `customer_id` rather than a `Customer`.
# Note that you do still need to write `OnlineOrder.find_by_customer`.

class OnlineOrder < Grocery::Order
  # OnlineOrder is an Order
  # customer object
  # fulfillment status (stored as a symbol): pending, paid, shipped, completed
  # if no status is provided, should be set to pending as default

  attr_reader :all, :total
  attr_accessor :id, :products, :products_hash, :cust_id, :status, :add_product

  def initialize(id, products, cust_id, status)
    @id = id
    @products = products
    @cust_id = cust_id
    @status = status

  end

  def self.all #the name, price setup the same, but includes the cust id, status
    orders = []

    CSV.read(ONLINE_ORDERS_CSV, "r").each do |row|
      products_hash = {}
      id = row[0].to_i
      products_string = row[1].split(";")

      products_string.each do |product| # "cucumber:5"
        key = product.split(":")[0] # ["cucumber", "5"]
        value = product.split(":")[1]
        products_hash[key] = value.to_f # or # products_hash.push(key: value)
      end

      cust_id = row[2].to_i
      status = row[3].to_sym

      orders << OnlineOrder.new(id, products_hash, cust_id, status) # shovel the sliced order into the global orders array
    end # each loop

    return orders

  end # all method

  def total
    return (super + 10).round(2)
  end

  def add_product(product_name, product_price, cust_id, status)
    if status != :pending || status != :paid
      raise ArgumentError.new("Can only add new product if your status is pending or paid")
    else
      if @products.key? product_name
        puts "This is already included in the order."
        return false
      else
        puts "Congrats, it's been added to your order."
        @products.store(product_name, product_price)
        @cust_id.store(cust_id)
        @status.store(status)
      end # inside if statement
    end # outside if
  end # add_product
end # OnlineOrder

# class Customer
#   attr_accessor :email
#
#   def initialize(id, email, delivery_address)
#     @id = id
#     @email = email
#     @delivery_address = delivery_address
#   end
# end
# bob = Customer.new(1,"x@y.com","123 Maple St");
# o = Order.new
# o.set_customer(bob);
# puts o.get_customer().email

# ---SEE ONLINE ORDERS
# order = OnlineOrder.all[16]
# puts "Order ID: #{order.id}\nProducts: #{order.products}\nCustomer ID: #{order.cust_id}\nCurrent Status: #{order.status}" #, Current Status: #{status}
# ---CALCULATE TOTAL
# online = OnlineOrder.all[99]
# puts online.total
#----ADD PRODUCT
order = OnlineOrder.all
puts order.add_product(101, {"juice"=>2}, 25, :shipped)
