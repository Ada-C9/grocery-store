require 'csv'
require 'awesome_print'
require_relative 'order'

class OnlineOrder < Grocery::Order

  attr_reader :id, :products, :status

  def initialize(id, products)
    @id = id
    @products = products
    @status = :pending
  end

  def total
    if super == 0
      return 0
    else
      return super + 10
    end
  end


  def add_product(product_name, product_price)
    if @status == :pending || @staus == :paid
      super(product_name, product_price)
    end

    if @status == :shipped || @status == :completed_statuses || @status == :processing
    else
      raise ArguementError.new("No updated status for the given order")
    end
  end
























end
