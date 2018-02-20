require "csv"
require "ap"

module Grocery
  class Customer
    attr_accessor :id, :email, :delivery_address
    def initialize(id, email, delivery_address)
      @id = id
      @email = email
      @delivery_address = delivery_address
    end

    def self.all
      customer_array = CSV.read("support/customers.csv", "r")
      all_customers = []
      customer_array.each do |info|
        id = info[0].to_i
        email = info[1].to_s
        address = "#{info[2]}, #{info[3]}, #{info[4]}, #{info[5]}"
        all_customers << Customer.new(id, email, address)
      end
      all_customers
    end


    def self.find(id)
      customer_list = self.all
      the_customer = nil
      customer_list.each do |info|
        if info.id == id
          the_customer = info
        end
      end
      return the_customer
    end
  end
end

ap Grocery::Customer.find(35)
