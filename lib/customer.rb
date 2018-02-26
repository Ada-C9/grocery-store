require 'csv'
require_relative 'order.rb'

module Grocery

class Customer
  attr_reader :id, :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end
  #
  # def self.all
  #   customer_objects = []
  #   CSV.read("support/customers.csv").each do |line|
  #     products_array = line[1].split(';')
  #
  #     products_array2 = []
  #     products_array.each do |product|
  #       products_array2 << product.split(':')
  #     end
  #
  #     products_hash = products_array2.to_h
  #     line = Order.new(line[0], products_hash)
  #     order_objects << line
  #   end
  #   return order_objects
  # end
  #
  # def self.find(id)
  #
  # end
end
end
