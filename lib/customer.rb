require 'pry'
require 'csv'
require 'awesome_print'
module Grocery
  class CustomerError < ArgumentError
    def initialize(msg="Error: CustomerID not found")
      super
    end
  end

  class Customer
    attr_reader :customer_id, :email, :address
    def initialize(id, email, address)
      @customer_id = id
      @email = email
      @address = address
    end

    def self.all
      customer_list = []
      CSV.read('support/customers.csv', 'r', headers:true, header_converters: :symbol).each do |row|
        # csv_list = []
        id = row[:id].to_i
        email = row[:email]
        address = [ row[:street], row[:state], row[:zipcode] ]
        customer_list << Grocery::Customer.new(id, email, address)
        end #CSV.read('support/customers.rb')
      return customer_list
    end # Customer.all

    def self.find(customer_id)
      self.all.each do |customer|
        if customer_id > all.length
          raise Grocery::CustomerError.new
        elsif
          customer.customer_id == customer_id
          return customer
        end
      end # self.all.each do
    end # Order.find
  end
end

binding.pry
