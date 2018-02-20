require 'csv'
require 'pry'

module Grocery

  # module Reuse
  #
  #   # def check_if_hash(initial_products)
  #   #   if initial_products.class != Hash
  #   #     raise ArgumentError.new("Products must be a Hash.")
  #   #   end
  #   # end
  #
  # end


  class Order

    # include Reuse

    attr_reader :id, :products

    @@all_orders = [] # stores all orders

    def initialize(initial_id, initial_products, is_new = true)
      @id = nil
      @products = nil
      set_id_if_valid(initial_id, is_new)
      set_products_if_valid(initial_products, is_new)
    end

    def total
      return get_cost_without_tax + get_sales_tax
    end


    def add_product(product_name, product_cost)
      return successfully_add_product?(product_name, product_cost)
    end

    # TODO: make when code isn't in flux/fucked up
    # def remove_product(product_name)
    #   successfully_removed_product?(product_name)
    # end

    def self.all
      return get_all
    end

    def self.find(requested_id)
      return all.find { |order| order.id == requested_id }
    end

    private

    def self.get_all
      build_all if @@all_orders.empty?
      return @@all_orders
    end

    def self.build_all
      CSV.read("../support/orders.csv").each do |order_line|
        order_id = order_line[0].to_i
        product_hash = build_products_hash(order_line[1])
        @@all_orders << Grocery::Order.new(order_id, product_hash, false)
      end
    end

    def self.build_products_hash(products_as_string)
      products_hash = {}
      products_as_string.scan(/[^\;]+/).each do |product|
          name, price = product.split(":")
          products_hash["#{name}"] = price.to_f
      end
      return products_hash
    end

    def set_id_if_valid(initial_id, is_new)
      check_initial_id(initial_id) if is_new
      @id = initial_id
    end

    def set_products_if_valid(initial_products, is_new)
      is_new ? check_products(initial_products) : @products = initial_products
    end

    def check_products(initial_products)
      check_if_hash(initial_products)
      @products = {}
      initial_products.each { |name, cost|
        add_product_if_valid_and_non_duplicate(name, cost) }
    end

    def get_sales_tax#(total_cost_with_out_tax)
      sales_tax_amount = (get_cost_without_tax * 0.075).round(2)
      # sales_tax_amount = (total_cost_with_out_tax * 0.075).round(2)
      # Not possible to have negative sales tax
      sales_tax_amount < 0.0 ? (return 0.0) : (return sales_tax_amount)
    end

    def get_cost_without_tax
      total_costs = 0.0
      @products.each_value { |cost| total_costs += cost if is_valid_cost?(cost) }
      return total_costs
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

    # Adds provided name and provided cost to
    def add_product_if_valid_and_non_duplicate(name, cost)
      @products["#{name}"] = cost if is_valid_product?(name, cost) &&
        !@products.has_key?(name)
    end

    # Returns "true" if provided name is a non-empty String with at least one
    # character, provided cost is a Float greater than or equal to 0, and the
    # provided name is not already a product name. Otherwise, returns 'false.'

    def is_valid_new_product?(name, cost)
      return is_valid_name?(name) && is_valid_cost?(cost) && !@products.has_key?(name)
    end

    #
    def is_valid_product?(name, cost)
      return is_valid_name?(name) && is_valid_cost?(cost)
    end

    # Returns 'true' if provided name is a non-empty String with at least one
    # character. Otherwise, returns 'false'.
    def is_valid_name?(name)
      return name.class == String && name.strip.length >= 1
    end

    # Returns 'true' if provided cost is a Float greater than or equal to 0.
    # Otherwise, returns 'false'.
    def is_valid_cost?(cost)
      return cost.class == Float && cost >= 0.0
    end


    def check_if_hash(initial_products)
      if initial_products.class != Hash
        raise ArgumentError.new("Products must be a Hash.")
      end
    end

    def check_initial_id(initial_id)
      if initial_id.class != Integer || !Grocery::Order.find(initial_id).nil?
        raise ArgumentError.new("Order ID must be a unique order ID number.")
      end
    end

  end
end
