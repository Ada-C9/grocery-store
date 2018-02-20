require 'csv'
require 'awesome_print'
require_relative '../lib/order'

@@online_orders
class Onlineorder < Grocery::Order
  attr_reader :customer, :status, :customer_ID
  def initialize(id, products,customer,status,customer_ID)
    super(id,products)
    @customer = customer
    @status = status
    @customer_ID = customer_ID
    if @status == nil
      @status = :pending
    end
  end

  def total
    shipping_fee = 10
    total = 0
    if @products == nil || @products.size == 0
      shipping_fee = 0
    else
      @products.values.each do |grocery_product|
        total += grocery_product
    end
  end
    return (total + shipping_fee + (total*0.075).round(2))
  end

  def add_product(product_name, product_price,status)
    confirm_value = true
    if status == :pending || :paid
      if @products[product_name] == nil
        @products[product_name] = product_price
      else
        confirm_value = false
      end
    else
      raise ArgumentError, 'Input is not pending or paid'
    end
    return confirm_value
  end

  def self.all
    cust_info = Grocery::Customer.all
    index = 0
    @@online_orders = []
      CSV.read('support/online_orders.csv').each do |line|
        food_orders_hash = {}
        an_id = line[0]
        food_by_order  = line[1].split(';')
        food_by_order.each do |value|
          food_pair = value.split(':')
          food_orders_hash[food_pair[0]] = food_pair[1].to_f
        end
        cust_ID = line[2]
        status = line[3].to_sym
        @@online_orders << Onlineorder.new(an_id,food_orders_hash,cust_info[index], status,cust_ID)
        index+=1
      end
      return @@online_orders
  end

  def self.find(input_id)
    searched_value = 0
    count = 0
    @@online_orders.each do |item|
      if item.id == input_id
        searched_value =  item
      else
        count+=1
      end
    end
      if count == @@online_orders.length
        raise ArgumentError, 'Input does not exist in the list'
      end
        return searched_value
      
  end

  def self.find_by_customer(customer_id)
    list_of_customers = []
    @@online_orders.each do |order|
      if order.customer == customer_id
        list_of_customers << order
      end
    end
    return list_of_customers
  end

end
