require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do

      id = 25
      email = "summer@casper.io"
      customer = Grocery::Customer.new(id, email, {})

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal email
      customer.email.must_be_kind_of String

      customer.must_respond_to :address
      customer.address.length.must_equal 0
      customer.address.must_be_kind_of Hash

    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      customers_entered = Grocery::Customer.all

      customers_entered.class.must_equal Array

      count = 0
      customers_entered.each do |order|
        count += 1
      end

       count.must_equal 35
    end

    it "Returns accurate information about the first customer" do
      all_customers = Grocery::Customer.all
      first_customer = all_customers[0]

      first_customer.id.must_equal 1
      first_customer.email.must_equal "leonard.rogahn@hagenes.org"
      first_customer.address.must_equal({:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"})
    end

    it "Returns accurate information about the last customer" do
      all_customers = Grocery::Customer.all
      last_customer = all_customers[-1]

      last_customer.id.must_equal 35
      last_customer.email.must_equal "rogers_koelpin@oconnell.org"
      last_customer.address.must_equal({:street=>"7513 Kaylee Summit", :city=>"Uptonhaven", :state=>"DE", :zip_code=>"64529-2614"})
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      first_customer = Grocery::Customer.find(1)

      first_customer.id.must_equal 1
      first_customer.email.must_equal "leonard.rogahn@hagenes.org"
      first_customer.address.must_equal({:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"})
    end

    it "Can find the last customer from the CSV" do
      last_customer = first_customer = Grocery::Customer.find(35)

      last_customer.id.must_equal 35
      last_customer.email.must_equal "rogers_koelpin@oconnell.org"
      last_customer.address.must_equal({:street=>"7513 Kaylee Summit", :city=>"Uptonhaven", :state=>"DE", :zip_code=>"64529-2614"})
    end

    it "Returns nil for a customer that doesn't exist" do
      fake_customer = Grocery::Customer.find(45)

      fake_customer.must_be_nil
    end
  end
end
