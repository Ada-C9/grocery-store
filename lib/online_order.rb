require_relative 'order'
require 'awesome_print'
require 'csv'

FILE_NAME = 'support/online_orders.csv'

# The OnlineOrder class will inherit behavior from the Order class
# and include additional data to track the customer and order status.
# An instance of the Customer class will be used within each instance
# of the OnlineOrder class.

module Grocery

  class OnlineOrder < Order

    attr_reader :customer_id, :status

    def initialize(id, products, customer_id, status)
      super(id, products)
      @customer_id = customer_id
      @status = status
    end

    def total
      if super == 0
        return nil
      else
        final_total = super + 10
      end
      return final_total
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        super
      else
        raise ArgumentError.new("A new product can be added ONLY if the status is either pending or paid")
      end
    end

    def self.all
      order_product = []
      result = {}
      all_online_order = []
      CSV.open(FILE_NAME, 'r').each do |product|
        order_product << "#{product[1]}"
        id = product[0].to_i
        customer_id = product[2].to_i
        status = product[3].to_sym
        order_product.each do |product_string|
          result = Hash[
            product_string.split(';').map do |pair|
              product, price = pair.split(':', 2)
              [product, price.to_i]
            end
          ]
        end
        all_online_order << Grocery::OnlineOrder.new(id,result, customer_id, status)
      end
      return all_online_order
    end

    def self.find(find_id)
      super
    end

    def self.find_by_customer(customer_id)
      find_product = self.all
      return_value = nil
      find_product.each do |order|
        if customer_id == order.customer_id
          return_value = order
        end
      end
      return return_value
    end

  end # class OnlineOrder

end # module Grocery
