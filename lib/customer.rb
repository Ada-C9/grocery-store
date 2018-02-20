require 'csv'
require 'awesome_print'



module Grocery

  class Customer

    attr_reader :id, :email, :customer_address

    def initialize(id, email, customer_address)
      @id = id
      @email = email
      @customer_address = customer_address

    end

    def self.all

      customer_list = []
      customer_instances = []

      CSV.read(File.join(File.dirname(__FILE__),'../support/customers.csv')).each do |row|
        customer_list << {id: row[0], email: row[1], customer_address: {street: row[2], city: row[3], state: row[4], zip: row[5]}}

      end

      customer_list.each do |customer|
        customer_instances << Grocery::Customer.new(customer[:id], customer[:email], customer[:customer_address])
      end

      return customer_instances

    end

    def self.find(customer_id)

    matched_customer = nil

    all_customers = Grocery::Customer.all

    all_customers.each do |customer|
      if customer.id == customer_id
        matched_customer = customer
        break
      end
    end

    if (matched_customer.nil?)
      raise RuntimeError "Invalid customer ID"
    end

      return matched_customer

  end
  end

end
