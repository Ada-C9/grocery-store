require 'csv'
require 'awesome_print'

CUSTOMER_FILE_NAME = 'support/customers.csv'


module  Grocery

  class Customer

    attr_reader :id, :email, :delivery_address

    def initialize(id, email, delivery_address)
      @id = id
      @email = email
      @delivery_address = delivery_address
    end

    def self.all
      all_customers = []
      CSV.open(CUSTOMER_FILE_NAME, 'r').each do |line|
        id = line[0].to_i
        email = line[1]
        delivery_address = "#{line[2]}, #{line[3]}, #{line[4]}"
        new_customer = Customer.new(id,email,delivery_address)
        all_customers << new_customer
      end
      return all_customers
    end

    def self.find(good_id)
          return_value = nil
          self.all.each do |customer|
            if customer.id == good_id
              return_value = customer
            end
          end
          return return_value
        end
      end
    end
