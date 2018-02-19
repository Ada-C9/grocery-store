require 'csv'

CUSTOMERS = "support/customers.csv"

module Grocery
  class Customer
    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    # return an array of Customer s
    def self.all
      customers = []
      CSV.read(CUSTOMERS, "r").each do |customer|
        id = customer[0].to_i
        email = customer[1]
        address = "#{customer[2]}, #{customer[3]}, #{customer[4]}, #{customer[5]}"
        customers << Customer.new(id, email, address)
      end
      return customers
    end

    def self.find(id)
      correct_customer = nil
      self.all.each do |customer|
        if customer.id == id
          correct_customer = customer
        end
      end

      if correct_customer != nil
        return correct_customer
      else
        ArgumentError
      end
    end

  end # class Order ends

end # module Grocery ends
