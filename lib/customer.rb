require 'csv'
require 'awesome_print'

FILE_NAME3 = 'support/customers.csv'

module Grocery

  class Customers
    attr_reader :id, :email_address, :delivery_address

  def initialize(id, email_address, delivery_address)
    @id = id
    @email_address = email_address
    @delivery_address = delivery_address

  end

    def self.all
      all_customers  = []
      CSV.open(FILE_NAME3, 'r').each do |line|
        id = line[0].to_i
        email_address = line[1]
        delivery_address = "#{line[2]}  #{line[3]}  #{line[4]}"

        new_customer = Customers.new(id, email_address, delivery_address)
        all_customers << new_customer
      end
      return all_customers
    end


    def self.find(id)
      array_customers = []
      all_customers = Grocery::Customers.all
      all_customers.each do |customer|
        array_customers << customer.id
        if array_customers.include? id
          return Customers.new(customer.id, customer.email_address, customer.delivery_address)
        end
      end
      return NIL
    end
  end
end
