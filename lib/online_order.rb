require 'csv'
require_relative 'customer'
require_relative 'order'

module Grocery
  class OnlineOrder < Grocery::Order
    attr_reader  :status, :customer

def initialize(id, products, customer, status = :pending)
  super(id.to_i, products)
  @customer = customer
  @status = status
end

def total
  if @products.keys.length > 0
    return super + 10
  else
    return super
  end
end

def add_product(product_name, product_price)
  if @status == :pending || @status == :paid
    super(product_name, product_price)
  else
    raise ArgumentError.new "Your order does not have the right status"
  end
end

def self.all
  all_orders = []
  CSV.read("support/online_orders.csv").each do |order|
    #0 id, 1 product string, 2 customer id, 3 status
    id = order[0].to_i
    products = {}
    item_price_array = order[1].split(";")
    item_price_array.each do |product|
      split_product = product.split(":")
      item = split_product[0]
      price = split_product[1].to_f
      product_hash = {item => price}
      products.merge!(product_hash)
    end
    customer = Grocery::Customer.find(order[2].to_i)
    status = order[3].to_sym
    all_orders << Grocery::OnlineOrder.new(id, products, customer, status)
  end
  return all_orders
end
    #inherits self.find from Order class
    def self.find_by_customer(customer_id)
      # Raise ArgumentError if collection of customer ids doesn't include the given customer_id
      if !(Grocery::Customer.all.map{|customer| customer.id}.include? customer_id)
        raise ArgumentError.new("Customer with ID #{customer_id} does not exist.")
      end
      customer_orders = []
      self.all.each do |online_order|
        if online_order.customer.id == customer_id
          customer_orders << online_order
        end
      end
      return customer_orders
    end

  end
end
