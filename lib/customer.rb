require 'csv'
require 'awesome_print'

#_______________ Grocery::Customer _______________

module Grocery
  class Customer

    attr_reader :customer_id, :email, :address

    # Initialize class Customer:
    def initialize(customer_id, email, customer_address)
      @customer_id = customer_id
      @email = email
      @address = customer_address
    end


    #############################################################################################
    def self.all
      # self.all - returns a collection of OnlineOrder instances, representing all of the OnlineOrders described in the CSV. See below for the CSV file specifications
      # Question Ask yourself, what is different about this all method versus the Order.all method? What is the same?
      # (Answer: 2 more indexes at the end 'costumer_id' & 'status' + different file)

      all_customers = []

      # Read file:
      # ???? why on rake I need to have the whole path here??
      read_file = CSV.read('/Users/leticiatran/Desktop/ada/c9_Ampers/ruby_projects/mini_projects/grocery-store/support/customers.csv', 'r')
      read_file.each do |row|
        # CSV.read('../support/orders.csv', 'r').each do |row|

        #Select the order id number from the file and assign it:
        customer_id = row[0]
        email = row[1]
        customer_address = "#{row[2]}, #{row[3]}, #{row[4]}"

        # Create new customer:
        new_customer = Customer.new(customer_id, email, customer_address)

        # Push this customer to all_custumers array
        all_customers << new_customer
      end
      return all_customers
    end


  end
end


all_customers = Grocery::Customer.all
puts all_customers
ap  all_customers[0]
