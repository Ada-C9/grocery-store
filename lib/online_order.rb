# online order
 #example

module Grocery

class OnlineOrder < Order

  attr_reader :id, :products :customer_id :status

  def initialize(id, products)
    @id = id
    @products = products
    @customer_id = customer_id
    @fulfillment_status = status.to_sym

    # tip from Katie: 16 and 22 are the customer id's that exsit but do not have orders


  end

  def self.all
    array_of_orders = []
    CSV.open("support/online_orders.csv", 'r').each do |line|

      product_list = line[1].split(';')
      product_hash = {}
      product_list.each do |item|
        product = item.split(':')
        product_hash[product[0]] = product[1]
      end
      array_of_orders << Grocery::OnlineOrder.new(line[0].to_i, product_hash, customer_id, fulfillment_status)
    end
    array_of_orders
  end

  def self.find(id)

  end

  def self.find_by_customer(customer_id)

  end

  def total
    shipping_fee = 10.0
    return super + shipping_fee
  end

  def add_product(product_name, product_price)
    return false if @products.has_key?(product_name)
    @products[product_name] = product_price
    return true
  end


# The add_product method should be updated to permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted)
# Otherwise, it should raise an ArgumentError (Google this!)



end # end of OnlineOrder Class


end # end of Module Class
