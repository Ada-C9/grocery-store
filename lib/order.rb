require 'csv'
require 'awesome_print'

ORDERS = "../support/orders.csv"
#  ORDERS = "support/orders.csv"
ONLINE_ORDERS = "../support/online_orders.csv"

module Grocery

  class Order
    attr_accessor :id, :all_orders, :products, :item_and_price_hash,
    :product_name, :product_price, :order_items, :order_number

    def initialize(id, products)
      @id = id
      @products = products
      @item_and_price_hash = item_and_price_hash
      @item_and_price_hash = {}
      @order_items = @products.split(';')
      @order_items.each do |item|
        item = item.split(':')
        @item_and_price_hash[item[0]] = item[1]
      end
    end


    def self.all(data_collection)
      @all_orders = []
      data_collection.each do |row|
        order = Grocery::Order.new(row[0], row[1])
        @all_orders << order
        # puts order.receipt
      end
      n = 1
      @all_orders.each do |index|
        puts "\n\nORDER #{n}:"
        index.receipt
        print "TOTAL: "
        puts index.total
        n += 1
      end
    end

    def self.find(id)
      if
        @all_orders.include?(@all_orders[id - 1])
        @all_orders[id - 1].receipt
        puts "Total: #{@all_orders[id - 1].total}"
      else
        puts "That order does not exist."
      end
    end


    def receipt
      puts "RECEIPT:"
      @item_and_price_hash.each do |key, value|
        puts "#{key}: #{value}"
      end
    end


    def total
      if
        @products.empty?
        return 0
      end

      total = 0
      tax = 0.075
      @item_and_price_hash.each do |item, price|
        total += price.to_f
      end
      total = total + (total * tax)
      return total.round(2)
    end

    def add_product(product_name, product_price)
      @product_name = product_name
      @product_price = product_price.to_f
      if @item_and_price_hash.has_key? @product_name
        return false
      else
        @item_and_price_hash[@product_name] = @product_price
        return @item_and_price_hash
      end
    end

    def remove_product(product_name)
      if @item_and_price_hash.has_key?(product_name)
        @item_and_price_hash.delete(product_name)
      else
        puts "Product is not on this order."
      end
    end
  end

  class OnlineOrder < Order
    attr_reader :customer_id
    attr_accessor :status

    def initialize(id, products, customer_id, status = :pending)
      super(id, products)
      @customer_id = customer_id.to_i
      @status = status
      if
        @status == nil
        @status = :pending
      else
        @status = status.to_sym
      end
    end

    def self.all(data_collection)
      @all_orders = []
      data_collection.each do |row|
        order = Grocery::OnlineOrder.new(row[0], row[1], row[2], row[3])
        @all_orders << order
      end
      n = 1
      @all_orders.each do |index|
        puts "\n\nORDER #{n}:"
        index.receipt
        print "TOTAL: "
        puts index.total
        print "CUSTOMER ID: "
        puts index.customer_id
        print "STATUS: "
        puts index.status
        n += 1
      end
    end

    def self.find(id)
       puts"\nSTATUS: #{@all_orders[id - 1].status}"
       puts"CUSTOMER ID: #{@all_orders[id - 1].customer_id}"
      return super
    end

    def self.find_by(customer_id)
      puts "ORDERS BY CUSTOMER ##{customer_id}:"
      @all_orders.each do |index|
        if index.customer_id == customer_id
          puts index.id
        end
      end
    end

    def total
      puts "\n*$10 SHIPPING FEE HAS BEEN ADDED*"
      return super + 10
    end

    def add_product(product_name, product_price)
      @product_name = product_name
      @product_price = product_price.to_f
      if
        @item_and_price_hash.has_key? @product_name
        return false
      elsif
        @status == :pending || @status == :paid
        @item_and_price_hash[@product_name] = @product_price
        return @item_and_price_hash
      else
        raise ArgumentError.new("ORDER CANNOT BE ADJUSTED WHILE PROCESSING, SHIPPED, OR COMPLETE")
      end
    end
  end
end

selection = 0
until selection == 1 || selection == 2
  puts "WELCOME. PLEASE MAKE A SELECTION (1 or 2)"
  puts "1.REGULAR ORDERS\n2.ONLINE ORDERS"
  print ">>> "
  selection = gets.chomp.to_i
  if selection == 1
    data = CSV.read(ORDERS)
    puts "ALL THE ORDERS IN THIS COLLECTION:"
    Grocery::Order.all(data)

    puts "\n\nWOULD YOU LIKE TO LOOK UP AN ORDER? (YES/NO)"
    print ">>> "
    finder_response = gets.chomp.upcase
    while finder_response != "NO"
      if finder_response == "YES"
        puts "\nWHICH ORDER WOULD YOU LIKE TO RETRIEVE?"
        print ">>> "
        retreiver_number = gets.chomp.to_i
        puts "\n****ORDER ##{retreiver_number}****"
        Grocery::Order.find(retreiver_number)
        puts "\n\nWOULD YOU LIKE TO LOOK UP AN ORDER? (YES/NO)"
        print ">>> "
        finder_response = gets.chomp.upcase
      else
        puts "THAT IS AN INVALID SELECTION"
        puts "\n\nWOULD YOU LIKE TO LOOK UP AN ORDER? (YES/NO)"
        print ">>> "
        finder_response = gets.chomp.upcase
      end
    end
    exit
  elsif selection == 2
    information = CSV.read(ONLINE_ORDERS)
    puts "ALL THE ORDERS IN THIS COLLECTION:"
    Grocery::OnlineOrder.all(information)

    puts "\n\nWOULD YOU LIKE TO LOOK UP AN ORDER? (YES/NO)"
    finder_response = gets.chomp.upcase

    while finder_response != "NO"
      puts "1.SEARCH BY ORDER ID\n2.SEARCH BY CUSTOMER ID"
      print ">>> "
      search_option = gets.chomp.to_i
      if search_option == 1
        puts "\nWHICH ORDER NUMBER WOULD YOU LIKE TO RETRIEVE?"
        print ">>> "
        retreiver_number = gets.chomp.to_i
        puts "\n****ORDER ##{retreiver_number}****"
        Grocery::OnlineOrder.find(retreiver_number)
        puts "\n\nWOULD YOU LIKE TO LOOK UP ANOTHER ORDER? (YES/NO)"
        finder_response = gets.chomp.upcase
      elsif search_option == 2
        puts "\nWHICH CUSTOMER ID WOULD YOU LIKE TO RETRIEVE?"
        print ">>> "
        retreiver_number = gets.chomp.to_i
        puts "\n****CUSTOMER ##{retreiver_number}****"
        Grocery::OnlineOrder.find_by(retreiver_number)
        puts "\n\nWOULD YOU LIKE TO LOOK UP ANOTHER ORDER? (YES/NO)"
        print ">>> "
        finder_response = gets.chomp.upcase
      else
        puts "THAT IS AN INVALID SELECTION"
        puts "\n\nWOULD YOU LIKE TO LOOK UP ANOTHER ORDER? (YES/NO)"
        print ">>> "
        finder_response = gets.chomp.upcase
      end
    end
    exit
  end
end
