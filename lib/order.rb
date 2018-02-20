require 'csv'
require 'awesome_print'
@@all_orders
module Grocery
class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      total = 0
      @products.values.each do |grocery_product|
        total += grocery_product
      end
      return (total + (total*0.075).round(2))
    end

    def add_product(product_name, product_price)
      confirm_value = true
      if @products[product_name] == nil
        @products[product_name] = product_price
      else
        confirm_value = false
      end
      return confirm_value
    end

    def self.all()
      @@all_orders = []
      # Pull in information from CSV file - info will be read in single line at a time, indexed by ','
      CSV.read('support/orders.csv').each do |line|
        #update to path to be able to be called from main terminal path.
        counter = 0
        store_id = line[0]

        # Deliminate string by uneeded character ';' & ':'
        food_by_order_line = line[1].split(';')
        food_by_order_line.each_with_index {|item,index|
          individualized_items = item.split(':')
          food_by_order_line[index] = [individualized_items[0],individualized_items[1].to_f]
         }

        # Shift orders from array of arrays to hash that represents a order per store ID.
        food_by_order_line_hash = {}
        food_by_order_line.each do |product|
          food_by_order_line_hash[product[0]] = product[1]
        end

        # Instantiates and pushes new grocery objects into an array.
        @@all_orders << Grocery::Order.new(store_id,food_by_order_line_hash)
        counter+=1
      end
      return @@all_orders
      end

      def self.find(id)
        check = true
        no_match = true
        counter_index = -1
        count_match = 0
        while check
          counter_index += 1
          if @@all_orders[counter_index] == nil
            count_match+=1
            if count_match == @@all_orders.length
              check = !check
              matched_obj = nil
            end
          elsif @@all_orders[counter_index].id == id
              matched_obj = @@all_orders[counter_index]
              check = !check
          end
       end
        return matched_obj
      end

  end
end
