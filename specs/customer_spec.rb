require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 1337
      email = "email@email.com"
      address = "123 Sycamore St"
      city = "Seattle"
      state = "WA"
      zip = "98144"
      customer = Grocery::Customer.new(id, email, address, city, state, zip)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.must_respond_to :address
      customer.must_respond_to :city
      customer.must_respond_to :state
      customer.must_respond_to :zip
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      Grocery::Customer.all.must_be_kind_of Array
    end

    it "Returns an array in which every item is a Customer" do
      Grocery::Customer.all.each do |customer|
        customer.must_be_kind_of Grocery::Customer
      end
    end

    it "Returns the correct number of customers" do
      Grocery::Customer.all.length.must_equal 35
    end

    it "Returns the ID, email, and address of the first customer in the CSV" do
      Grocery::Customer.all.first.id.must_equal 1
      Grocery::Customer.all.first.email.must_equal "leonard.rogahn@hagenes.org"
      Grocery::Customer.all.first.address.must_equal "71596 Eden Route"
      Grocery::Customer.all.first.city.must_equal "Connellymouth"
      Grocery::Customer.all.first.state.must_equal "LA"
      Grocery::Customer.all.first.zip.must_equal "98872-9105"
    end

    it "Returns the ID, email, and address of the last customer in the CSV" do
      Grocery::Customer.all.last.id.must_equal 35
      Grocery::Customer.all.last.email.must_equal "rogers_koelpin@oconnell.org"
      Grocery::Customer.all.last.address.must_equal "7513 Kaylee Summit"
      Grocery::Customer.all.last.city.must_equal "Uptonhaven"
      Grocery::Customer.all.last.state.must_equal "DE"
      Grocery::Customer.all.last.zip.must_equal "64529-2614"
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      Grocery::Customer.find(1).email.must_equal "leonard.rogahn@hagenes.org"
      Grocery::Customer.find(1).address.must_equal "71596 Eden Route"
      Grocery::Customer.find(1).city.must_equal "Connellymouth"
      Grocery::Customer.find(1).state.must_equal "LA"
      Grocery::Customer.find(1).zip.must_equal "98872-9105"
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find(35).email.must_equal "rogers_koelpin@oconnell.org"
      Grocery::Customer.find(35).address.must_equal "7513 Kaylee Summit"
      Grocery::Customer.find(35).city.must_equal "Uptonhaven"
      Grocery::Customer.find(35).state.must_equal "DE"
      Grocery::Customer.find(35).zip.must_equal "64529-2614"
    end

    it "Raises an error for a customer that doesn't exist" do
      proc { Grocery::Customer.find(36) }.must_raise ArgumentError
    end
  end
end
