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

  # status: pending, paid, processing, shipped, complete

  def total
    if super == 0
      return 0
    else
      return super + 10
    end
  end

  # The add_product method should be updated to permit a new product to be added
  # ONLY if the status is either pending or paid (no other statuses permitted)
  # Otherwise, it should raise an ArgumentError (Google this!)
  def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        super(product_name, product_price)
      end

      # TODO: Fix this!
      if @status == :processing || @status == :shipped || @status == :complete
        raise ArgumentError.new("ArgumentError")
      end
  end

  # self.all - returns a collection of OnlineOrder instances, representing all of the OnlineOrders described in the CSV. See below for the CSV file specifications
  # Question Ask yourself, what is different about this all method versus the Order.all method? What is the same?
  def self.all
    return OnlineOrder.parse_csv
  end

  # 1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete
  # ID, products, customer ID, status
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

  # self.find(id) - returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter.
  # Question Ask yourself, what is different about this find method versus the Order.find method?
  def self.find(id)
    online_orders = OnlineOrder.all
    online_orders.each do |online_order|
      if online_order.id == id
        return online_order
      end
    end
    return nil
  end

  # self.find_by_customer(customer_id) - returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
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

# puts Grocery::Customer.find(25)
# puts Grocery::Customer.find(25).id
# OnlineOrder.all
