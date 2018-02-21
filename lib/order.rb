require 'csv'

# This program creates a new OnlineOrder. It also calculates the total of the
# order, adds products to the order, and removes products.
module Grocery
  class Order

    attr_reader :id, :products

    @@all_orders = [] # stores all orders after all is called

    def initialize(initial_id, initial_products)
      @id = has_valid_id_or_error(initial_id) # stores order id
      @products = {} # stores each product in order
      set_products_if_valid(initial_products)
    end

    # Returns the total cost of the order.
    def total
      cost_without_tax = get_cost_without_tax
      return cost_without_tax + get_sales_tax(cost_without_tax)
    end

    # Adds provided product_name and product_cost as a product if they makes
    # valid product. Returns 'true' if this was successful and 'false' otherwise
    def add_product(product_name, product_cost)
      return successfully_add_product?(product_name, product_cost)
    end

    # Removes provided product_name if is a name of a current order. Returns
    # 'true' if the product was removed and 'false' otherwise.
    def remove_product(product_name)
      return successfully_remove_product?(product_name)
    end

    # Returns a list of all Orders.
    def self.all
      return get_all
    end

    # Returns order with the id that matches provided requested_id. If there is
    # no order with requested_id, returns nil.
    def self.find(requested_id)
      return find_order_by_id(requested_id)
    end

    private

    # Returns a list of all orders.
    def self.get_all
      build_all if @@all_orders.empty?
      return @@all_orders
    end

    # Populates all_orders with all the orders.
    def self.build_all
      @@all_orders = [] # hard reset of @@all_orders each time method is called
      CSV.read('../support/orders.csv').each do |order_line|
        order_id = order_line[0].to_i
        products_hash = build_products_hash(order_line[1])
        @@all_orders << Grocery::Order.new(order_id, products_hash)
      end
    end

    # Creates the collection of products using the names and cost in provided
    # products_as_string.
    def self.build_products_hash(products_as_string)
      products_hash = {}
      products_as_string.scan(/[^\;]+/).each do |product|
          name, price = product.split(":")
          products_hash["#{name}"] = price.to_f
      end
      return products_hash
    end

    # Returns order with the id that matches provided requested_id. If there is
    # no order with requested_id, returns nil.
    def self.find_order_by_id(requested_id)
      return all.find { |order| order.id == requested_id }
    end

    # Throws ArgumentError if provided initial_products is not a Hash.
    #
    # Adds each valid projects to the collections of products for the order.
    def set_products_if_valid(initial_products)
      has_hash_or_error(initial_products)
      initial_products.each { |name, cost| add_new_product_if_valid(name, cost) }
    end

    # Returns the sales tax for the provided cost_without_tax.
    def get_sales_tax(cost_without_tax)
      sales_tax_amount = (cost_without_tax * 0.075).round(2)
      # Not possible to have negative sales tax
      return sales_tax_amount < 0.0 ?  0.0 : sales_tax_amount
    end

    # Returns the total costs of all the products in the order (not including
    # taxes and rounded to two decimal places)
    def get_cost_without_tax
      total_costs = 0.0
      @products.each_value { |cost| total_costs += cost if is_valid_cost?(cost) }
      return total_costs
    end

    # Adds provided product_name and product_cost as a product if they makes
    # valid product. Returns 'true' if this was successful and 'false' otherwise.
    def successfully_add_product?(product_name, product_cost)
      original_num_of_products = @products.length
      add_new_product_if_valid(product_name, product_cost)
      return original_num_of_products != @products.length
    end

    # Removes the product with the provided product_name if it is a product in
    # the order. Returns 'true' if this was successful and 'false' otherwise.
    def successfully_remove_product?(product_name)
      return is_valid_name?(product_name) && !@products.delete(product_name).nil?
    end

    # Adds provided name and provided cost as a new product if they create a
    # valid product.
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

    # Returns 'true' if provided cost is a Float greater than or equal to 0.0.
    # Otherwise, returns 'false'.
    def is_valid_cost?(cost)
      return cost.class == Float && cost >= 0.0
    end

    # Throws ArgumentError is provided possible_hash is not a Hash.
    def has_hash_or_error(possible_hash)
      if possible_hash.class != Hash
        raise ArgumentError.new("#{possible_hash.inspect} must be a Hash.")
      end
    end

    # Pre: throws ArgumentError is provided initial_id is not an int or had a
    # value less than one.
    #
    # Returns initial_id as a valid id.
    def has_valid_id_or_error(initial_id)
      if initial_id.class != Integer || initial_id < 1
        raise ArgumentError.new("Order ID must be a number greater than 0.")
      end
      return initial_id
    end

  end
end
