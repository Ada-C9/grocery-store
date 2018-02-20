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
  products = {}
  elements_of_order.each do |item|
    # Assign the product of this element in this order:
    product =  "#{item.split(':')[0]}" #.split.map(&:capitalize).join(' ')
    # puts "product : #{product}"

    # Assign the price of this element in this order:
    price =  "#{item.split(':')[1]}"
    # puts "price : #{price}"

    #Push the Product and the Price into the array products for this order:
    products["#{product}"] = price.to_f
    # puts "products: #{products}"
  end
  # ap "this is products #{products}"
  return products
end



#############################################################################################
# FIND ORDER:
    def self.find
      # self.find(id) - returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter. -Question Ask yourself, what is different about this find method versus the Order.find method?
    end

#############################################################################################
# FIND ORDER BY COSTUMER:

    def self.find_by_costumer(costumer_id)
      # self.find_by_customer(customer_id) - returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
    end

  end
end

# products = {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
# online_order = Grocery::OnlineOrder.new(1, products, 25, :paid)

# ap online_order.total
# ap online_order.status
# ap online_order.add_product("Lobster", 17.18)
# online_order = Grocery::OnlineOrder.new
# online_order = Grocery::OnlineOrder.all
#  ap online_order
