require 'csv'
require 'awesome_print'
require_relative 'order.rb'

module Grocery
class OnlineOrder < Grocery::Order
  attr_reader :id, :products, :customer_id, :status

  def initialize(id, products, customer_id, status = :pending)
    @online_id = id
    @products = products
    @customer_id = customer_id
    @status = status #pending, paid, processing, shipped or complete
  end

  #  The total method should be the same, except it will add a $10 shipping fee
  def total
    return 10 + super
  end

  def add_product
    # The add_product method should be updated to permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted)
    # Otherwise, it should raise an ArgumentError (Google this!)
  end

  def self.all
    # self.all - returns a collection of OnlineOrder instances, representing all of the OnlineOrders described in the CSV. See below for the CSV file specifications
    # Question Ask yourself, what is different about this all method versus the Order.all method? What is the same?
  end

  def self.find
    # self.find(id) - returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter. -Question Ask yourself, what is different about this find method versus the Order.find method?
  end

  def self.find_by_costumer(costumer_id)
    # self.find_by_customer(customer_id) - returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
  end

end
end

products = {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
online_order = Grocery::OnlineOrder.new(1, products, 25, "complete")

ap online_order.total
ap online_order.status
