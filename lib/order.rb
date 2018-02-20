require 'csv'

module Grocery

  class Order

    attr_reader :id, :products

    @@all_orders = [] # stores all orders

    def initialize(initial_id, initial_products)
      @id = has_valid_id_or_error(initial_id)
      @products = {}
      set_products_if_valid(initial_products)
    end

    def total
      return get_cost_without_tax + get_sales_tax
    end

    def add_product(product_name, product_cost)
      return successfully_add_product?(product_name, product_cost)
    end

    def remove_product(product_name)
      return successfully_remove_product?(product_name)
    end

    def self.all
      return get_all
    end

    def self.find(requested_id)
      return find_order_by_id(requested_id)
    end

    private

    def self.get_all
      build_all if @@all_orders.empty?
      return @@all_orders
    end

    # P
    def self.build_all
      @@all_orders = [] # hard reset of @@all_orders each time method is called
      CSV.read("../support/orders.csv").each do |order_line|
        order_id = order_line[0].to_i
        products_hash = build_products_hash(order_line[1])
        @@all_orders << Grocery::Order.new(order_id, products_hash)
      end
    end

    def self.build_products_hash(products_as_string) # online_order keeps as is
      products_hash = {}
      products_as_string.scan(/[^\;]+/).each do |product|
          name, price = product.split(":")
          products_hash["#{name}"] = price.to_f
      end
      return products_hash
    end

    def self.find_order_by_id(requested_id)
      return all.find { |order| order.id == requested_id }
      # return self.all.find { |order| order.id == requested_id }
    end

    def set_products_if_valid(initial_products)
      has_hash_or_error(initial_products)
      initial_products.each { |name, cost| add_new_product_if_valid(name, cost) }
    end

    def get_sales_tax
      sales_tax_amount = (get_cost_without_tax * 0.075).round(2)
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
       add_new_product_if_valid(name, cost)
       return original_num_of_products != @products.length
    end

    # TODO: all fucked up but not fixing until all data structure is fixed.
    # This is for remove_product but it doesn't actually remove yet(?)
    def successfully_remove_product?(name)
      return is_valid_name?(name) && !@products.delete(name).nil?
    end

    # Adds provided name and provided cost to
    def add_new_product_if_valid(name, cost)
      @products[name] = cost if is_valid_new_product?(name, cost)
    end

    # Returns "true" if provided name is a non-empty String with at least one
    # character, provided cost is a Float greater than or equal to 0, and the
    # provided name is not already a product name. Otherwise, returns 'false.'
    def is_valid_new_product?(name, cost)
      return is_valid_name?(name) && is_valid_cost?(cost) &&
        !@products.has_key?(name)
    end

    # Returns 'true' if provided name is a non-empty String with at least one
    # character. Otherwise, returns 'false'.
    def is_valid_name?(name)
      return name.class == String && name.match(/[a-zA-Z]+?/)
    end

    # Returns 'true' if provided cost is a Float greater than or equal to 0.
    # Otherwise, returns 'false'.
    def is_valid_cost?(cost)
      return cost.class == Float && cost >= 0.0
    end

    #
    def has_hash_or_error(possible_hash)
      if possible_hash.class != Hash
        raise ArgumentError.new("#{possible_hash.inspect} must be a Hash.")
      end
    end

    #
    def has_valid_id_or_error(initial_id)
      if initial_id.class != Integer || initial_id < 1
        raise ArgumentError.new("Order ID must be a number greater than 0.")
      end
      return initial_id
    end

  end
end
