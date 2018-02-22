require 'csv'
require 'awesome_print'
@@all_customers
module Grocery
  class Customer
    attr_reader :id, :email, :address
    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    def self.all
      @@all_customers = []
      CSV.read('support/customers.csv').each do |line|
        an_id = line[0]
        an_email = line[1]
        an_address = line[2] + " " + line[3] + " " + line[4] + " " + line[5]
        @@all_customers << Grocery::Customer.new(an_id,an_email,an_address)
      end
      return @@all_customers
    end

    def self.find(id)
      no_match_count = 0
      user_id_confirm = 0
      @@all_customers.each do |customer|
        if customer.id == id
          user_id_confirm = customer
        else
          no_match_count+=1
        end
      end

      if no_match_count == @@all_customers.length
        user_id_confirm = nil
      end
      return user_id_confirm
    end

  end
end
