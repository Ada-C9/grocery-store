require 'csv'
require 'awesome_print'
require_relative 'order.rb'


#_______________ Grocery::OnlineOrder _______________

module Grocery
  class OnlineOrder < Grocery::Order

    attr_reader :id, :products, :customer_id, :status

    # Initialize class OnlineOrder:
    def initialize(id, products, customer_id, status = :pending)
      super(id, products)
      @customer_id = customer_id
      @status = status #pending, paid, processing, shipped or complete
    end


    #############################################################################################
    # TOTAL  OF ORDER:

    #  The total method should be the same, except it will add a $10 shipping fee
    # it "Doesn't add a shipping fee if there are no products" do
    def total
      if @products != nil
        return 10 + super
      end
    end


    #############################################################################################
    # ADD PRODUCT TO ORDER:


    def add_product(product_name, product_price)
      # The add_product method should be updated to permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted)
      # Otherwise, it should raise an ArgumentError (Google this!)
      unless @status == :paid || @status == :pending
        raise ArgumentError.new("Only paid or pending status is allowed.")
      end
      super(product_name, product_price)
    end

    #############################################################################################
    # ALL ORDERS:

    def self.all
      # self.all - returns a collection of OnlineOrder instances, representing all of the OnlineOrders described in the CSV. See below for the CSV file specifications
      # Question Ask yourself, what is different about this all method versus the Order.all method? What is the same?
      # (Answer: 2 more indexes at the end 'costumer_id' & 'status' + different file)

      @all_orders = []

      # Read file:
      # ???? why on rake I need to have the whole path here??
      read_file = CSV.read('/Users/leticiatran/Desktop/ada/c9_Ampers/ruby_projects/mini_projects/grocery-store/support/online_orders.csv', 'r')
      read_file.each do |row|
        # CSV.read('../support/orders.csv', 'r').each do |row|

        #Select the order id number from the file and assign it:
        order_id = row[0]
        customer_id = row[2]
        status = row[3]

        # Separete the elements after the first comma (index[1]) into {product_name, product_price} and assign it to a products variable:
        products = separate("#{row[1]}".split(';'))
        # example => puts products = [{"Allspice"=>"64.74"}, {"Bran"=>"14.72"}, {"UnbleachedFlour"=>"80.59"}]

        # Push this order (order id, products(itens, price)) to the array of orders
        @all_orders << [order_id, products, customer_id, status]
      end
      return @all_orders
    end

    # Separete the elements into (product_name, product_price):
    def self.separate(elements_of_order)
      super  #(The same as in Grocery::Order.separate)
    end



    #############################################################################################
    # FIND ORDER:
    def self.find(find_id)
      # self.find(id) - returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter. -Question Ask yourself, what is different about this find method versus the Order.find method?
      #(Answer: Nothing! )
      super

    end

    #############################################################################################
    # FIND ORDER BY COSTUMER:

    def self.find_by_costumer(costumer_id)
      # self.find_by_customer(customer_id) - returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
      all_specific_costumer_orders = []

      @all_orders.count.times do |order|
        if @all_orders[order][2] == "#{costumer_id}"
          # ap  @all_orders[order][2]
          # if order[2] == costumer_id
          specific_costumer_order = @all_orders[order]
          #   if (order + 1) == costumer_id
          # return @all_orders[order]
          # "Order #{@all_orders[order][0]}: products: #{@all_orders[order][1]}"
          all_specific_costumer_orders << specific_costumer_order
        end
      end


      if all_specific_costumer_orders.size == 0
        return "Costumer doesn't exist or has no orders!"
      else
        return all_specific_costumer_orders
      end



    end
  end
end


  #############################################################################################

  # TEMRINAL PERSONAL TESTSING:

  # products = {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
  # online_order = Grocery::OnlineOrder.new(1, products, 25, :paid)

  # ap online_order.total
  # ap online_order.status
  # ap online_order.add_product("Lobster", 17.18)

  # online_order = Grocery::OnlineOrder.all
  #  ap online_order

  # online_order = Grocery::OnlineOrder.all
  # find_id = Grocery::OnlineOrder.find(100)
  # ap "#{find_id}"
  # print "#{find_id}"

  # Grocery::OnlineOrder.all
  # ap "BY COSTUMER: #{Grocery::OnlineOrder.find_by_costumer(99)}"
