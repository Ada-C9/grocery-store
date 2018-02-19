require 'csv'
require 'awesome_print'
require_relative 'order.rb'
require_relative 'customer.rb'

ONLINE_FILE_NAME = 'support/online_orders.csv'


module  Grocery

  class OnlineOrder < Order
    attr_reader :customer_id, :status

    def initialize(id, products, customer_id, status)
      super(id, products)
      @customer_id = customer_id
      @status = status.to_sym
    end


    def total
      if @products.length > 0
        return (super()+10).round(2)
      else
        return 0
      end
    end

    def add_product(name, price)
      if [:pending, :paid].include?(@status)
        super(name,price)
      end
    end

    def customer
      return_value = nil

      Grocery::Customer.all.each do |customer|
        if customer.id == @customer_id
          return_value = customer
        end
      end

      return return_value
    end # method - customer

    def self.all
      all_orders = []
      CSV.open(ONLINE_FILE_NAME, 'r').each do |str|
        new_hash = {}
        id = str[0].to_i
        customer_id = str[2].to_i
        status = str[3]

        str[1].split(";").each do |pair|
          new_pair = pair.split(":")
          key = new_pair[0]
          value = new_pair[1].to_f
          new_hash[key] = value
        end
        new_order = OnlineOrder.new(id, new_hash, customer_id, status)
        all_orders << new_order
      end
      return all_orders
    end # method - self.all

    def self.find_by_customer(cust_id)
      cust_array = Grocery::Customer.all
      id_array = []
      cust_array.each do |customer|
        id_array << customer.id
      end

      return_value = []
      if id_array.include?(cust_id)
        self.all.each do |online_order|
          if online_order.customer_id == cust_id
            return_value << online_order
          end
        end # all.each do
        return return_value
      else
        return nil
      end # if statement

    end # method - find by customer


  end # Class - OnlineOrder

end # Module - Grocery
