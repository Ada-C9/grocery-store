require 'csv'
require 'awesome_print'
require 'pry'
# TODO: what to do about had initialize values??

module Grocery
  class Order

    @@all = []

    attr_reader :id, :products

    def initialize(order_id, order_products)
      @id = order_id
      @products = order_products
    end

    def total
      cost_without_sales_tax = get_cost_without_sales_tax
      return cost_without_sales_tax + get_sales_tax(cost_without_sales_tax)
    end

    # def add_product(product_name, product_cost)
    #   is_new_product = is_valid_new_product?(product_name, product_cost)
    #   add_new_product(product_name, product_cost) if is_new_product
    #   return is_new_product
    # end

    def add_product(product_name, product_cost)
      return successfully_add_product?(product_name, product_cost)
    end

    # TODO: make when code isn't in flux/fucked up
    # def remove_product(product_name)
    #   successfully_removed_product?(product_name)
    # end

    def self.all
      if @@all.empty?
        CSV.read("../support/orders.csv").each do |order|
          order_id = order[0].to_i
          product_hash = {}
          order[1].scan(/[^\;]+/).each do |one_order|
              name, price = one_order.split(":")
              product_hash["#{name}"] = price.to_f
          end
          @@all << Order.new(order_id, product_hash)
        end
      end
      return @@all
    end

    def self.find(requested_id)
      return @@all.find { |order| order.id == requested_id }
    end


private


    def get_sales_tax(total_cost_with_out_tax)
      sales_tax_amount = (total_cost_with_out_tax * 0.075).round(2)
      # Not possible to have negative sales tax
      sales_tax_amount < 0.0 ? (return 0.0) : (return sales_tax_amount)
    end

    def get_cost_without_sales_tax
      total_costs = 0.0
      @products.each_value { |cost| total_costs += cost if is_valid_cost?(cost) }
      return total_costs
    end

    # product_name must be a String
    def has_product_key?(new_name)
      # return @products.any? { |product| product[name] == new_name }
       @products.has_key?(new_name)
    end


    def successfully_add_product?(name, cost)
       original_num_of_products = @products.length
       add_product_if_valid_and_non_duplicate(name, cost)
       return original_num_of_products != @products.length
    end

    # TODO: all fucked up but not fixing until all data structure is fixed.
    # This is for remove_product but it doesn't actually remove yet(?)
    def successfully_removed_product?(name)
      return is_valid_name?(name) && @products["#{name}"].nil?
    end

    #
    def add_product_if_valid_and_non_duplicate(name, cost)
      # @products.push({name: new_name, price: new_cost }) if
      #   is_valid_new_product?(new_name, new_cost)
      @products["#{name}"] = cost if is_valid_new_product?(name, cost)
    end

    def is_valid_new_product?(name, cost)
      return is_valid_product?(name, cost) && !has_product_key?(name)
    end

    def is_valid_product?(name, cost)
      return is_valid_name?(name) && is_valid_cost?(cost)
    end

    def is_valid_name?(name)
      return name.class == String && name.length >= 1
    end

    def is_valid_cost?(cost)
      return cost.class == Float
    end

  end
end

# This version of self breaks up products for initializing new orders.
# def self.all
#   if @@all.empty?
#     CSV.read("../support/orders.csv").each do |order|
#       order_id = order[0]
#       order_products = []
#       list_of_each_product_as_sting = order[1].split(";")
#       list_of_each_product_as_sting.each do |product_as_string|
#       # order[1].split(";").each do |product_as_string|
#         name_and_price = product_as_string.split(":")
#         product = { name: name_and_price[0], price: name_and_price[1] }
#         order_products.push(product)
#       end
#     @@all << Order.new(order_id, order_products)
#     end
#   end
#   return @@all
# end
