require_relative './order.rb'

module Grocery

  class OnlineOrder < Order
    attr_reader :customer_id, :status

    def initialize (id, products, customer_id, status)
      super(id, products)
      # @online_total = online_total
      @status = status
      @customer_id = customer_id
    end

    def total
      return 10 + super
    end

    def self.find(id)
      online_orders = OnlineOrder.all
      online_orders.each do |o|
        if o.id == id
          return o
        end
      end

      return nil
    end

    def self.all
      require 'csv'
      # csv = CSV.open("../support/online_orders.csv")r
      csv = CSV.open("support/online_orders.csv")
      online_orders_list = []
      csv.each do |l|
        products = { }
        #puts l[1].split(';')

        product_string = l[1]
        customer_id = l[2].to_i
        status = l[3]

        product_smash = product_string.split(';')
        product_smash.each do |ps|
          # ps = "name1:val1"
          items = ps.split(':')
          # hash_entry = {items[0] => items[1].to_f}
          # products.push(hash_entry)
          products[items[0]] = items[1].to_f

        end  # end of product_smash.each

        online_order = OnlineOrder.new(l[0].to_i, products,customer_id,status)
        online_orders_list.push(online_order)

      end # end of csv.each

      return online_orders_list
    end

    def self.find_by_customer(customer_id)
      online_orders = OnlineOrder.all
      online_orders.each do |c|
        if c.customer_id == customer_id
          return c
        end
      end

      return nill
    end

    def add_product(name,price)
      if status == "pending" || status == "paid"
        return super(name,price)
      else
        raise ArgumentError.new("Unacceptable Order Status")
        # return nil
      end
    end

  end

end

id = 12
products = { "abcd" => 12.3 }
customer_id = "tim"
status = "broken"

oo = Grocery::OnlineOrder::new(id, products, customer_id, status)
puts oo.total


id = 12
products = { "abcd" => 12.3 }
customer_id = "tim"
status = "broken"

oo = Grocery::OnlineOrder::new(id, products, customer_id, status)

puts Grocery::OnlineOrder::find_by_customer(35).products


  #   def self.all
  #   end
  #
  #
  #   def self.find(id)
  #  end
  #
  # if status == "pending"
  #   return "*"
  # elsif status == "paid"
  #   return "$"
  # elsif status == "processing"
  #   return "#"
  # elsif status == "shipped"
  #   return == "&"
  # elsif status == "complete"
  #    return "***"
  # else
  #   return "*"
  # end
  #
  # # order = Grocery::Order.new( 1337, {})
  # # products = { "banana" => 1.99, "cracker" => 3.00 }
  # # order = Grocery::Order.new(1337, products)
  # # puts products
