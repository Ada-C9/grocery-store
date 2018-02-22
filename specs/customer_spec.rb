require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'
require 'awesome_print'

Minitest::Reporters.use!

describe "Customer" do

  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 1
      email = "leonard.rogahn@hagenes.org"
      address = {street: "71596 Eden Route", city: "Connellymouth", state: "LA", zip: "98872-9105"}
      customer = Grocery::Customer.new(id, email, address)

      customer.must_respond_to :id
      customer.id.must_equal 1
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal "leonard.rogahn@hagenes.org"
      customer.email.must_be_instance_of String

      customer.must_respond_to :address
      customer.address.must_be_instance_of Hash
      customer.address.length.must_equal 4
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      customers = Grocery::Customer.all

      customers.must_be_instance_of Array
      customers.each do |customer|
        customer.must_be_instance_of Grocery::Customer
      end
      customers.length.must_equal 35
    end

    it "Returns accurate information about the first customer" do
      customers = Grocery::Customer.all
      first_customer = customers.first

      # 1,leonard.rogahn@hagenes.org,71596 Eden Route,Connellymouth,LA,98872-9105
      first_customer.id.must_equal 1
      first_customer.email.must_equal "leonard.rogahn@hagenes.org"
      first_customer.address[:street].must_equal "71596 Eden Route"
      first_customer.address[:city].must_equal "Connellymouth"
      first_customer.address[:state].must_equal "LA"
      first_customer.address[:zip].must_equal "98872-9105"
    end

    it "Returns accurate information about the last customer" do
      customers = Grocery::Customer.all
      last_customer = customers.last

      # 35,rogers_koelpin@oconnell.org,7513 Kaylee Summit,Uptonhaven,DE,64529-2614
      last_customer.id.must_equal 35
      last_customer.email.must_equal "rogers_koelpin@oconnell.org"
      last_customer.address[:street].must_equal "7513 Kaylee Summit"
      last_customer.address[:city].must_equal "Uptonhaven"
      last_customer.address[:state].must_equal "DE"
      last_customer.address[:zip].must_equal "64529-2614"
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      customer_found = Grocery::Customer.find(1)

      # 1,leonard.rogahn@hagenes.org,71596 Eden Route,Connellymouth,LA,98872-9105
      customer_found.id.must_equal 1
      customer_found.email.must_equal "leonard.rogahn@hagenes.org"
      customer_found.address[:street].must_equal "71596 Eden Route"
      customer_found.address[:city].must_equal "Connellymouth"
      customer_found.address[:state].must_equal "LA"
      customer_found.address[:zip].must_equal "98872-9105"
    end

    it "Can find the last customer from the CSV" do
      customer_found = Grocery::Customer.find(35)

      # 35,rogers_koelpin@oconnell.org,7513 Kaylee Summit,Uptonhaven,DE,64529-2614
      customer_found.id.must_equal 35
      customer_found.email.must_equal "rogers_koelpin@oconnell.org"
      customer_found.address[:street].must_equal "7513 Kaylee Summit"
      customer_found.address[:city].must_equal "Uptonhaven"
      customer_found.address[:state].must_equal "DE"
      customer_found.address[:zip].must_equal "64529-2614"
    end

    it "Return nil for a customer that doesn't exist" do
      customer_found = Grocery::Customer.find(36)

      customer_found.must_be_nil
    end
  end

end
