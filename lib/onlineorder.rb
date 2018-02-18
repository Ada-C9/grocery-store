require 'csv'
require_relative 'order.rb'

module Grocery

class OnlineOrder < Order

  attr_reader :id, :products, :customer, :status

  def initialize(id, products, customer, status)
    super(id, products)
    @customer = customer
    @status = status
  end

  def self.all
    oorder_objects = []
    CSV.read("support/online_orders.csv").each do |line|
      products_array = line[1].split(';')

      products_array2 = []
      products_array.each do |product|
        products_array2 << product.split(':')
      end
      products_hash = products_array2.to_h
      line = OnlineOrder.new(line[0], products_hash, line[2], line[3].to_sym)
      oorder_objects << line
    end
    return oorder_objects

  end
  #
  def self.find(id)
    OnlineOrder.all.each do |object|
      if object.id == id
        return object
      end
    end
    return nil
  end

  def self.find_by_customer(customer)
    OnlineOrder.all.each do |object|
      if object.customer.to_i == customer
        return object
      end
    end
    return nil
  end

  def total
    if super > 0
      return super + 10
    else
      return 0
    end
  end

  def add_product(product_name, product_price)
    if @status == :paid || @status == :pending
      super
      # if @products.key?(product_name)
      #   return !@products.key?(product_name)
      # else
      #   @products[product_name] = product_price
      #   return true
      # end
    else
      return nil
    end

  end
  #
  # def remove_product(product_name)
  #   if @products.key?(product_name)
  #     @product.delete(product_name)
  #     return true
  #   else
  #     return false
  #   end
  # end

end


end
