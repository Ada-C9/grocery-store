require 'awesome_print'
require 'csv'

FILE_NAME = "support/customers.csv"

class Customer
  attr_reader :id, :email, :address

  # 3 param
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # return an array
  def self.all
    customers = []
    CSV.read(FILE_NAME, "r").each do |customer|
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
      return nil
    end
  end

end # Customer class ends

# ap Customer.all
