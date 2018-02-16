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

    def self.find(id)

    end


  end

end

# ap Grocery::Customer.all
