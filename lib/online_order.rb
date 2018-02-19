require "csv"
require "awesome_print"

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :customer, :status
    attr_accessor :products

    # set to pending as the default
    def initialize(id, products, customer, status = :pending)
      super(id, products)
      @customer = customer
      @status = status
    end

    def self.all
      online_orders_all = []
      CSV.read('support/online_orders.csv', 'r').each do |row|
        products = row[1].split(';') # splits products string
        # turns products array strings into hashes
        product_hash = {}
        products.each do |string|
          product = string.split(':')
          product_hash[product[0]] = product[1]
        end
        customer = Grocery::Customer.find(row[2])
        # csv rows: row[0] => id, row[1] => products, row[2] => customer, row[3] => status
        online_orders_all << self.new(row[0], products, customer, row[3].to_sym)
      end
      return online_orders_all
    end
  end
end
