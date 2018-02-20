require 'csv'
require 'awesome_print'

ONLINE_FILE_NAME = 'support/online_order.csv'


module  Grocery

  class Onlineorder < Order

    attr_reader :customer_id, :status

    def initialize(id, products, customer_id, status)
      super(id, products)
      @customer_id = customer_id
      @status = status.to_symbol
    end

    def total
      if @products.length > 0
        return (super()+10).round(2)
      else
        return 0
      end
    end

    def add_product(product_name, product_price)
      if [:pending, :paid].include?(@status)
        super(product_name,product_price)
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
    end

    def self.all
      all_orders = []
      CSV.open(ONLINE_FILE_NAME, 'r').each do |num|
        new_hash = {}
        id = num[0].to_i
        customer_id = num[2].to_i
        status = num[3]

        str[1].split(";").each do |items|
          new_items = items.split(":")
          key = new_items[0]
          value = new_items[1].to_f
          new_hash[key] = value
        end
        new_order = OnlineOrder.new(id, new_hash, customer_id, status)
        all_orders << new_order
      end
      return all_orders
    end # method - self.all

    def self.find_by_customer(customer_id)
      customer_array = Grocery::Customer.all
      customer_id_array = []
      customer_array.each do |customer|
        customer_id_array << customer.id
      end

      return_value = []
      if customer_id_array.include?(customer_id)
        self.all.each do |online_order|
          if online_order.customer_id == customer_id
            return_value << online_order
          end
        end
        return return_value
      else
        return nil
      end
    end
  end
end
