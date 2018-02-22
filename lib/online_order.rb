require 'awesome_print'
require 'pry'
require 'csv'
require_relative 'order'
require_relative 'customer'


module Grocery

# Custom ArgumentError because it's fun, could also be done at the point of raising the ArgumentError using syntax ArgumentError.new("Custom Error Message")
  class CartError < ArgumentError
    def initialize(msg="Error: Items cannot be added to this order based on its current status")
      super
    end
  end

  class OnlineOrder < Order
    attr_reader :customer, :status
    @@all_online_orders = []
    @@customers = []

    def initialize(id, products, customer_id, status = :pending)
      #Use the itialize attributes from the parent class Order
      super(id, products)
      @customer = customer_id
      @status = status.to_sym
    end # Initialize

    def total
      unless @products.length == 0
        return super + 10
      end
    end

    def add_product(product_name, product_price)
      if @status == :paid || @status == :pending
        super
      else
        begin
          raise CartError
        rescue
        end
      end
    end

    def self.customers
      return @@customers
    end

    def self.all
      if @@all_online_orders.length == 0
        self.populate
      end
        return @@all_online_orders
    end

    def self.populate
      CSV.open('support/online_orders.csv', 'r', headers: true, header_converters: :symbol).each do |row|
        products = {}
        id = row[:id].to_i
        customer_id = row[:customer_id].to_i
        status = row[:status].to_sym
        row[:products].split(';').each do |item|
          name, price = item.split(':')
          products[name] = price.to_f
        end
        @@all_online_orders << index = self.new(id, products, customer_id, status)
        @@customers << Grocery::Customer.find(customer_id)
      end
      return @@all_online_orders
    end # OnlineOrder.all

    def self.find(id)
      populate
      if id > @@all_online_orders.length
        raise Grocery::FindError.new
      else
        return all[all.index(id)]
      end
      # @@all_online_orders.each do |order|
      #   if order.id == id
      #     return order
      #   end
      # end # self.all.each do
    end # Order.find

    def self.find_by_customer(cust_id)
      orders_by_customer = []

      all.each do |order|
        if cust_id > Grocery::Customer.all.length
          raise Grocery::CustomerError.new
        elsif
          order.customer == cust_id
          orders_by_customer << order
        end # if order.customer
      end #all.each do |order|
      return orders_by_customer
    end #self.find_by_customer

  end # OnlineOrder
end # Grocery
Grocery::OnlineOrder.all
