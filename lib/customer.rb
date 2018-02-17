require "csv"
require "awesome_print"

module Grocery
  class Customer
    attr_reader :id
    attr_accessor :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

  end
end
