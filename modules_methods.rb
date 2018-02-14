module Grocery

  class Order
    attr_reader :id

    def initialize(id, products_hash)
      @products = products_hash
      @id = id
    end

    def total
      
    end

  end

end
