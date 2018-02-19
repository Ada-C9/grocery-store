require "csv"
require_relative "order"
require_relative "customer"

ONLINEORDERS = "support/online_orders.csv"

module Grocery
  class OnlineOrder < Grocery::Order
    attr_reader :id, :products, :customer_id, :status

    def initialize(id, products, customer_id, status)
      super(id, products)
      @customer_id = customer_id
      @status = status
    end

    # Modify total method to include shipping fee
    def total
      shipping_fee = 10
      if super != 0
        return super + shipping_fee
      else
        return super
      end
    end

    # Modify add_method from parent class
    # Only permit one new product to be added when status is pending or paid
    def add_product(product_name, product_price)
      if @status == "pending" || @status == "paid"
        if !@products.keys.include?(product_name)
          @products[product_name] = product_price
        end
      else
        ArgumentError
      end
    end

    # return an array of OnlineOrder s
    def self.all
      online_orders = []
      CSV.read(ONLINEORDERS, "r").each do |online_order|
        id = online_order[0].to_i
        orders = online_order[1].split(%r{;\s*})
        # To put address info together
        order_hash = {}
        orders.each do |order|
          pair = order.split(%r{:\s*})
          order_hash[pair[0]] = pair[1]
        end
        products = order_hash
        customer_id = online_order[2].to_i
        status = online_order[3]
        online_orders << OnlineOrder.new(id, products, customer_id, status)
      end
      return online_orders
    end # self.all method ends

    def self.find(id)
      correct_order = nil
      self.each do |each_order|
        if each_order.id == id
          correct_order = each_order
        end
      end  # Q: return an instance of OnlineOrder rather than Order

      if correct_order != nil
        return correct_order
      else
        return nil
      end

    end # self.find method ends

    def self.find_by_customer(customer_id)
      target_customer = []
      self.each do |each_order|
        if each_order.customer_id == customer_id
          target_customer << each_order.id
          target_customer << each_order.products
          target_customer << each_order.customer_id
          target_customer << each_order.status
        end
      end

      if target_customer != []
        return target_customer
      elsif
        target_customer[1] = nil
        return
        target_customer = []
      else
        ArgumentError
      end

    end # self.find_by_customer emthod ends

  end # class OnlineOrder ends

end # module Grocery ends

# ap OnlineOrder.all

# Customer.find(OnlineOrder.customer_id)
