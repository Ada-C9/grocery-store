require "csv"
require_relative 'order.rb'

# class to handle online orders
class OnlineOrder < Grocery::Order

  attr_reader :id, :products, :customer_id, :fulfillment_status

#Takes an ID and collection of products
  def initialize(id, products, customer_id, fulfillment_status)
    if id == id.to_i
      @id = id
    else
      id = rand(1111..9999)
      @id = id
    end
    @products = products
    @customer_id = customer_id
    @fulfillment_status = fulfillment_status
  end

  #Returns the total price from the collection of products
  def total
    # TODO: implement total
    # super invokes the `total` method on the _base class_ (Order)
    # it will add a $10 shipping fee, unless total is zero
    if super == 0
       return 0
    else
       return super + 10
    end
  end

  def add_product(product_name, product_price)
    #permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted)
    if @fulfillment_status == :pending || @fulfillment_status == :paid
       super
    else
      # raise ArgumentError.new("Error - It is too late to add products to this order.")
    end
  end

  def self.all
    arr_onlineorders = Array.new
    CSV.read('support/online_orders.csv', 'r').each do |line|
      arr_onlineorders << line
    end

    arr_onlineorders.each do |line|
      id = line[0].to_i
      line[0] = id
      @id = id

      fulfillment_status = line[3].to_sym
      line[3] = fulfillment_status
      @fulfillment_status = fulfillment_status

      customer_id = line[2].to_i
      line[2] = customer_id
      @customer_id = customer_id

      products = line[1].split(";")
      line[1] = products
      array_split = Array.new
      line[1].each do |element|
        array_split << element.split(":")
      end

      array_split.each do |item|
        item[1] = item[1].to_f
      end

      line[1] = array_split.to_h
      end
      return arr_onlineorders
    end

    def self.find(id_lookup)
      OnlineOrder.all[(id_lookup-1)]
    end

end
