require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative "../lib/customer"
require "csv"

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
    object =  Grocery::Customer.new(35, "winirarrazaval@gmail.com", "7622 SE 22nd St" )
    object.id.must_equal 35
    object.email.must_equal "winirarrazaval@gmail.com"
    object.delivery_address.must_equal "7622 SE 22nd St"
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
    array = Grocery::Customer.all
    array.must_be_kind_of Array
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      object = Grocery::Customer.find(1)
      object.id.must_equal 1
      object.email.must_equal "leonard.rogahn@hagenes.org"
      object.delivery_address.must_equal "71596 Eden Route, Connellymouth, LA, 98872-9105"

    end

    it "Can find the last customer from the CSV" do
      object = Grocery::Customer.find(35)
      object.id.must_equal 35
      object.email.must_equal "rogers_koelpin@oconnell.org"
      object.delivery_address.must_equal "7513 Kaylee Summit, Uptonhaven, DE, 64529-2614"

    end

    it "Raises an error for a customer that doesn't exist" do
      object = Grocery::Customer.find(100).must_be_nil
    end
  end
end
