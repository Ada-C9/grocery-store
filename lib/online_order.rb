require 'csv'
require 'awesome_print'
require_relative 'order'

class OnlineOrder < Grocery::Order

  attr_reader :id, :products, :status

  def initialize(id, products, status = :pending)
    super(id, products)
    @status = :pending
  end

  def total
    super()
    if super == 0
      return 0
    else
      return super + 10
    end
  end


  def add_product(product_name, product_price, product_status)
    if @status == :pending || @staus == :paid
      super(product_name, product_price)
    end

    if @status == :shipped || @status == :completed || @status == :processing
    else
      raise ArguementError.new("ArgumentError") #not sure what to do here....HELP!
    end
  end

    def self.all
      #online order instances?
      return OnlineOrder.parse_csv
    end


    def self.parse_csv
      all_data = []

      all_orders = CSV.open("../support/orders.csv")

      all_orders.each do |file|
        @id = file[0].to_i
          @status = file[3].to_sym

        item = file[1].split(';')
        item_price = item.map! do |row|
          Hash[row.split(':').first,row.split(':').last]
        end
        item_price = item_price.reduce(:merge)
        @products = item_price

        all_data << Order.new(@id, @products, @status)
      end
      return all_data
    end

  def self.find(id)
    all_orders = OnlineOrder.all

    all_orders.each do |item|
      if item.id == id
        return item.products
      end
    end
    return nil
  end





end
