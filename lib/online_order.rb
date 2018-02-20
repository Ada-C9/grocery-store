require 'awesome_print'
require 'pry'
require 'csv'

FILENAME = "support/online_order.csv"

class Online_order
  # Inherit behavior from order class
  attr_accessor :status

  def initialize(id, products, status = :pending)
    super(id, products)
    @customer_id = customer_id
    @Status = status
    if status == nil
      status = :pending
    else
      @status = status.to_sym
    end
  end
  # same as order except will add $10 shipping fee
  def total
    super()
    return sum += 10
  end

  # update add_product to permit new product to be added only if the status is either pending or paid
  def add_product(product_name, product_price)
    super()
    unless status == pending || status == paid
      raise ArgumentError, "INVALID STATUS"
    end
  end

  # returns a collection of online_order instances ID, products, customer_id, status
  def self.all
    data = CSV.read(FILENAME)
  end

  #return a collection of online_order instances where the value of the id in the csv match the passed parameter.
  def self.find(id)
  end

  #returns a list of online_order instances where the value of the customer_id matches passed parameter
  def self.find_by_customer(customer_id)
  end

end
