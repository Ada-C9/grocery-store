module Grocery
  class Customer
    attr_reader :id, :email, :address

    def initialize id, email, address
      @id = id.to_i
      @email = email
      @address = address
    end

    def self.all
      all_customers =  CSV.read("support/customers.csv").map do |customer|
        Grocery::Customer.new(customer[0].to_i, customer[1], customer[2..5].join(", "))
      end
      return all_customers
    end

    def self.find(id)
      self.all.each do |customer|
        return customer if customer.id == id
      end
      raise ArgumentError.new("Customer ID #{id} does not exist.")
    end

  end
end
