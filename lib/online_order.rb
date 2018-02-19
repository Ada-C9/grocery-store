require 'awesome_print'
require 'pry'
require 'csv'
require_relative 'order'
require_relative 'customer'


module Grocery
  class OnlineOrder < Order
    attr_accessor :customer, :status

    def initialize(id, products, customer_id, status = :pending)
      @id = id
      @products = products
      @customer = Grocery::Customer.find(customer_id)
      @customer_id = customer_id
      @status = status.to_sym
    end # Initialize

    def total
      unless @products == 0
        return super + 10
      end
    end

    def add_product
      super
      # TODO: permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted) Otherwise it should raise an ArgumentError (maybe a custom one, why not?)
    end

    def self.all
      online_list_all = []
      CSV.open('support/online_orders.csv', 'r').each do |row|
        products = {}
        id = row[0].to_i
        status = row[-1]
        customer_id = row[-2].to_i
        row[1].split(';').each do |item|
          product = item.split(':')
          name = product[0]
          price = product[1].to_f
          products[name] = price
        end
        online_list_all << self.new(id, products, customer_id, status)
      end
      return online_list_all
    end # OnlineOrder.all

    def self.find(id)
      #TODO determine how this differs from the Order find method
    end

    def self.find_by_customer(customer_id)
      #TODO returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter
    end

  end # OnlineOrder
end # Grocery

binding.pry
