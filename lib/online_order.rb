require 'csv'
require 'awesome_print'
require_relative 'order.rb'


#_______________ Grocery::OnlineOrder _______________

module Grocery
  class OnlineOrder < Grocery::Order

    attr_reader :customer_id, :status

    # Initialize class OnlineOrder:
    def initialize(id, products, customer_id, status = :pending)
      super(id, products)
      @customer_id = customer_id.to_i
      @status = status #pending, paid, processing, shipped or complete
    end


    #############################################################################################
    # TOTAL  OF ORDER:

    #  The total method should be the same, except it will add a $10 shipping fee
    # it "Doesn't add a shipping fee if there are no products" do
    def total

      if @products != nil
        return 10 + super
      else
        return 0
      end

    end


    #############################################################################################
    # ADD PRODUCT TO ORDER:

    # The add_product method should be updated to permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted)
    def add_product(product_name, product_price)

      unless @status == :paid || @status == :pending
        raise ArgumentError.new("Only paid or pending status is allowed.")
      end
      super(product_name, product_price)

    end

    #############################################################################################
    # ALL ORDERS:

    # self.all - returns a collection of OnlineOrder instances, representing all of the OnlineOrders described in the CSV. See below for the CSV file specifications
    def self.all

      @all_orders = []

      # Read file:
      read_file = CSV.read('support/online_orders.csv', 'r')

      read_file.each do |row| # CSV.read('../support/orders.csv', 'r').each do |row|
        #Select the order id number from the file and assign it:
        order_id = row[0].to_i
        customer_id = row[2].to_i
        status = row[3]

        # Separete the elements after the first comma (index[1]) into {product_name, product_price} and assign it to a products variable:
        products = separate("#{row[1]}".split(';'))
        # example => puts products = [{"Allspice"=>"64.74"}, {"Bran"=>"14.72"}, {"UnbleachedFlour"=>"80.59"}]

        # Push this order (order id, products(itens, price)) to the array of orders
        new_order = OnlineOrder.new(order_id, products, customer_id, status)
        @all_orders << new_order
      end
      return @all_orders
    end


    # Separete the elements into (product_name, product_price):
    def self.separate(elements_of_order)
      super  #(The same as in Grocery::Order)
    end



    #############################################################################################
    # FIND ORDER:

    # def self.find(find_id)
    #   super #(The same as in Grocery::Order)
    # end

    # ---> NOT NECESSARY TO DUPLICATE

    #############################################################################################
    # FIND ORDER BY COSTUMER:

    # self.find_by_customer(customer_id) - returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
    def self.find_by_customer(costumer_id)

      all_specific_costumer_orders = []

      @all_orders.count.times do |order|
        if @all_orders[order].id == "#{costumer_id}"
          # ap  @all_orders[order][2]
          # if order[2] == costumer_id
          specific_costumer_order = @all_orders[order]
          #   if (order + 1) == costumer_id
          # return @all_orders[order]
          # "Order #{@all_orders[order][0]}: products: #{@all_orders[order][1]}"
          all_specific_costumer_orders << specific_costumer_order
        end
      end

      return all_specific_costumer_orders

      #### If figure out how to separate empty orders from non-existing customers
      # if all_specific_costumer_orders.size == 0
      #   return "Costumer doesn't exist or has no orders!"
      # else
      #   return all_specific_costumer_orders
      # end

    end
  end
end
