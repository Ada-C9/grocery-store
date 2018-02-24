module Grocery
  class OnlineOrder < Order
    attr_reader :id
    attr_accessor :products

    def initialize(id, products, customer_id)
      super
      @customer_id = customer_id
      @fulfillment_status = pending
    end
  end # end of class
end # end of module
