require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      #Arrange
      id = 1337
      email = "test@gmail.com"
      address = "221B Baker St, London NW1, 6XE, UK"

      #Act
      customer = Grocery::Customer.new(id, email, address)

      #Assert
      customer.must_respond_to :customer_id
      customer.customer_id.must_equal id
      customer.customer_id.must_be_kind_of Integer
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      result = Grocery::Customer.all

      result.must_be_kind_of Array
      result[15].must_be_kind_of Grocery::Customer
      result[0].email.must_match (/leonard.rogahn@hagenes.org/)
      result[-1].email.must_match (/rogers_koelpin@oconnell.org/)

    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
    result = Grocery::Customer.find(1)

    result.email.must_match (/leonard.rogahn@hagenes.org/)
    end

    it "Can find the last customer from the CSV" do
      last = Grocery::Customer.all[-1].customer_id
      result = Grocery::Customer.find(last)

      result.email.must_match (/rogers_koelpin@oconnell.org/)

    end

    it "Raises an error for a customer that doesn't exist" do
      proc {Grocery::Customer.find(1337)}.must_raise Grocery::CustomerError
    end
  end
end
