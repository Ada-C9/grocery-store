require 'csv'
require 'awesome_print'
require_relative 'order'
require_relative 'customer'

class OnlineOrder < Grocery::Order

  attr_reader :id, :products, :customer, :status

  def initialize(id, products, customer, status = :pending)
    super(id, products)

    @customer = customer
    @status = status
  end

  # Return the total cost of an OnlineOrder instance
  def total
    if super == 0
      return 0
    else
      return super + 10
    end
  end

  # Add product name and price to @products of an OnlineOrder instance
  def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        super(product_name, product_price)
      end

      if @status == :processing || @status == :shipped || @status == :complete
        raise ArgumentError.new("ArgumentError")
      end
  end

  # Return an array of OnlineOrder instances
  def self.all
    return OnlineOrder.parse_csv
  end

  # Helper method to parse CSV file into an array of OnlineOrder instances
  def self.parse_csv
    arr_of_arrs = CSV.read('support/online_orders.csv')
    online_orders = []
    arr_of_arrs.each do |row|
      product_string = row[1].split(";")
      product_hash = product_string.map do |x|
        x = x.split(":")
        Hash[x.first, x.last.to_f]
      end
      product_hash = product_hash.reduce(:merge)

      id = row[0].to_i
      products = product_hash
      customer_id = row[2].to_i
      status = row[3].to_sym

      customer = Grocery::Customer.find(customer_id)
      online_orders << OnlineOrder.new(id, products, customer, status)
    end
    return online_orders
  end

  # Return an OnlineOrder instance searched by online order id
  def self.find(id)
    online_orders = OnlineOrder.all
    online_orders.each do |online_order|
      if online_order.id == id
        return online_order
      end
    end
    return nil
  end

  # Return an array of OnlineOrder instances searched by customer id
  def self.find_by_customer(customer_id)
    online_orders = OnlineOrder.all
    online_orders_found = []
    online_orders.each do |online_order|
      if online_order.customer.id == customer_id
        online_orders_found << online_order
      end
    end
    return online_orders_found
  end

end
