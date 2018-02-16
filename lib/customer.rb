require 'csv'
require 'awesome_print'

module Grocery

  class Customer
    attr_reader :id, :email, :address_1, :city, :state, :zip_code
    def initialize id, email, address_1, city, state, zip_code
      @id = id
      @email = email
      @address_1 = address_1
      @city = city
      @state = state
      @zip_code = zip_code
    end

  end

end
