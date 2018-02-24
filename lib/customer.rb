require_relative '../lib/order'
require 'csv'
require 'awesome_print'
module Grocery

  class Customer < Grocery::Order
      attr_reader :id, :email, :address1, :city, :state, :zipcode

      #overriding initiazize method from Order class
      #self.initialize
      def initialize(id, email, address1, city, state, zipcode)
        super(id) = id
        @email = email
        @address1 = address1
        @city = city
        @state = state
        @zipcode = zipcode
      end


    def self.all
      #overriding the self.all method of super classes
      c = []
      customer_info_csv=CSV.read("support/customers.csv", 'r',headers: true).to_a

      customer_info_csv.each do |line|
        c << Grocery::Customer.new(*line)
      end
      c
    end

    #overrides order class method .find
    def self.find(id)
      a = self.all

      if id > a.length
        return nil
      end

      if id >=1
        specific_customer = a[id-1]
      elsif id < 0
        specific_customer = a[id]
      else
        return nil
      end
      return specific_customer
    end
  end


end

#customer = Grocery::Customer.new(5, 'bbb@gm', 'there', 'tt', 'oo', 'pp')

#ap Grocery::Customer.all
#ap customer_info_csv
#puts Grocery::Customer.find(5)
#array = Grocery::Customer.all
