require_relative '../lib/online_order'
require 'csv'

module Grocery

  class Customer < Grocery::OnlineOrder

    #do we need this? Are we already intialziing or i
    #is it diff for factory
    # def initialize(position)
    #   @position = position
    # end

    # This is the class method, it starts with self.
    # It is only called on the class directly Pawn.make_row
    def self.all
      #id
      #email address
      #delivery address information
      customer_info_csv = CSV.read("support/customers.csv", 'r',headers: true).to_a

      # customer = []
      # customer_info_csv.each do |line|
      #   # Here we call the new method of the current class
      #   customer << self.all
      return customer_info_csv
    end



  end


end
array = Grocery::Customer.all

ap array

puts "this is something"
