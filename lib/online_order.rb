require "./order.rb"
include Grocery

ONLINE_FILE_NAME = "../support/online_orders.csv"

class OnlineOrder < Grocery::Order
  attr_accessor :status, :products
  attr_reader :customer_id, :id
  def initialize(id,customer_id,status="pending",products)
    @customer_id = customer_id
    @status = status
    @products = products
    @id = id
  end

  def total
    # super() figure out how to get order
  end

  def add_product(product_name, product_price)
    unless self.status == "pending" || self.status == "paid"
      begin
        raise ArgumentError.new("You can only add products to orders with a status of 'Pending' or 'Paid'")
      rescue ArgumentError => e
        puts e.message
        return
      end
    end
    super
  end

  def self.all
    all_online_orders = []

    CSV.open(ONLINE_FILE_NAME, "r").each do |line|

      id = line[0].to_i
      status = line[-1]
      customer_id = line[-2].to_i
      products = {}
      product_array = line[1].split(";")
      product_array.each do |item|
        split_item = item.split(":")
        product_name = split_item[0]
        product_price = split_item[1].to_f
        products[product_name] = product_price
      end
      all_online_orders << self.new(id,customer_id,status,products)
    end
    return all_online_orders
  end

  def self.find(id)
    self.all.each do |online_order|
      return online_order if online_order.id == id
    end
  end

  def self.find_by_customer(customer_id)
    customer_orders = []
    self.all.each do |online_order|
      if online_order.customer_id == customer_id
        customer_orders << online_order
      end
    end
    return customer_orders
  end

end

puts OnlineOrder.ancestors.inspect
my_order = OnlineOrder.find(13)
ap my_order.add_product("apple",3.20)
ap my_order
# puts my_order.inspect
# puts my_order.status.class
# ap OnlineOrder.all
# ap my_order.inspect
# ap OnlineOrder.find(16)
# ap OnlineOrder.find_by_customer(25)
