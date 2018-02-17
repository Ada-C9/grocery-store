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
      CSV.open(CUSTOMER_FILE_NAME, 'r').each do |row|
        id = row[0].to_i
        email = row[1]
        delivery_address = "#{row[2]}, #{row[3]}, #{row[4]}"
        new_customer = Customer.new(id,email,delivery_address)
        all_customers << new_customer
      end # CSV each do
      return all_customers
    end # Self.all method

    def self.find(passed_id)
      return_value = nil
      self.all.each do |customer|
        if customer.id == passed_id
          return_value = customer
        end
      end
      return return_value
    end


  end # Class - Customer

end # Module - Grocery

# ap Grocery::Customer.all

ap Grocery::Customer.find(23)
