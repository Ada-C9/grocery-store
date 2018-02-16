require 'csv'
require 'awesome_print'

class OnlineOrder < Grocery::Order
  attr_reader :id, :products, :customer, :status

  def initialize(id, products, customer, status = :pending)
    @id = id
    @products = products
    @customer = customer
    @status = status
  end

  # return super + 10
  def total
  end

  # The add_product method should be updated to permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted)
  # Otherwise, it should raise an ArgumentError (Google this!)
  def add_product
  end

  # self.all - returns a collection of OnlineOrder instances, representing all of the OnlineOrders described in the CSV. See below for the CSV file specifications
  # Question Ask yourself, what is different about this all method versus the Order.all method? What is the same?
  def self.all
  end

  def self.parse_csv
  end

  # self.find(id) - returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter.
  # Question Ask yourself, what is different about this find method versus the Order.find method?
  def self.find(id)
  end

  # self.find_by_customer(customer_id) - returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
  def self.find_by_customer(customer_id)
  end

end
