require "csv"
require "awesome_print"

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :customer, :products, :status

    # set to pending as the default
    def initialize(id, products, customer, status = :pending)
      super(id, products)
      @customer = customer
      @status = status
    end

    def self.all
      online_orders_all = []
      CSV.read('support/online_orders.csv', 'r').each do |row|products = row[1].split(';') # splits products string
        # turns products array strings into hashes
        product_hash = {}
        products.each do |string|
          product = string.split(':')
          product_hash[product[0]] = product[1].to_f
        end
        customer = Grocery::Customer.find(row[2])
        # csv rows: row[0] => id, row[1] => products, row[2] => customer, row[3] => status
        online_orders_all << self.new(row[0], product_hash, customer, row[3].to_sym)
      end
      return online_orders_all
    end

    def total
      if @products.count >0
        return super + 10
      else
        return super
      end
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        return super
      end
      # will use proc syntax for testing
      raise ArgumentError.new("Error: Products can not be added to orders that are processing, shipped, or complete")
    end

    #self.find should come from Grocery::Order
  end
end
