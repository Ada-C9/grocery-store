require 'csv'
require 'awesome_print'
# TODO: what to do about had initialize values??

module Grocery
  class Order

    # @@all_products = get_all_producers

    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products

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

    def all

    end

    def find
    end

    private

    # def get_all_producers
    #   all_orders = CSV.read("../support/orders.csv")
    #   all_orders.each do |order|
    #
    # end

    # Pre: provided cost_without_sales_tax must be a double or int.
    #
    # If the sales tax (7.5% and rounded to two decimal places) for provided
    # total_cost_with_out_tax is greater than 0.0, returns the sales tax. Otherwise,
    # returns  0.0.
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
    def add_product_if_valid_and_non_duplicate(name, cost)#(new_name, new_cost)
      # @products.push({name: new_name, price: new_cost }) if
      #   is_valid_new_product?(name, cost)
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
