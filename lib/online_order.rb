require 'csv'
require 'awesome_print'
require 'money'
require_relative '../lib/order'
require_relative '../lib/customer'
I18n.enforce_available_locales = false

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :customer, :status

    def initialize(id, products, customer, status)
      super(id, products)
      @customer = customer
      @status = status
    end

    def total
      sum_with_tax_fee = super
      if sum_with_tax_fee != Money.new(0, "USD")
        sum_with_tax_fee += Money.new(1000, "USD")
      end
      return sum_with_tax_fee
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        true_false = super(product_name, product_price)
        # true if product added, false if product not added
        return true_false
      end
      # unsure how to make this an argument error instead of a standard error
      raise StandardError.new("Error: Can't add product. Order status is #{@status}.")
    rescue StandardError => e
      return e.message
    end

    def self.all
      online_orders_entered = []
      CSV.read("/Users/brandyaustin/ada/week2/grocery_store/grocery-store/support/online_orders.csv").each do |row|
        id = row[0].to_i
        products = {}
        products_array = row[1].split(";")

        products_array.each do |item|
          name, price = item.split(':')
          products[name] = price.to_f
        end

        customer = "placeholder"
        Grocery::Customer.all.each do |customer_object|
          if customer_object.id == row[2].to_i
            customer = customer_object
          end
        end

        if row[3].nil?
          status = :pending
        else
          status = row[3].to_sym
        end
        online_orders_entered << OnlineOrder.new(id, products, customer, status)
      end
      return online_orders_entered
    end

    def self.find(id)
      online_orders_entered = self.all
      online_orders_entered.each do |online_order|
        if online_order.id == id
          return online_order
        end
      end
      raise StandardError.new("Error: No online orders exists with that ID.")
    rescue StandardError => e
      return e.message
    end

    def self.find_by_customer(customer_id)
      valid = false
      Grocery::Customer.all.each do |customer|
        if customer.id == customer_id
            valid = true
        end
      end

      if valid == true
        online_orders_entered = self.all
        customers_online_orders = []
        online_orders_entered.each do |online_order|
          if online_order.customer.id == customer_id
            customers_online_orders << online_order
          end
        end
        return customers_online_orders
      end

        raise StandardError.new("Error: No customer exists with that ID.")
      rescue StandardError => e
        return e.message
    end

  end
end
