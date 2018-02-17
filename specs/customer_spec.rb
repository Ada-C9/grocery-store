require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require 'awesome_print'

Minitest::Reporters.use!

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # arrange
      id = 1234
      email = "kathryn@lindcasper.net"
      address = "995 Harris Track,Ryanborough,HI,67820"
      # act
      customer =Grocery::Customer.new(id, email, address)
      # assert
      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      # asserts that the email is a valid email address (found by searching 'regex for email ruby')
      assert_match(/[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+/, customer.email)
      # customer.email.must_include "@"

      customer.must_respond_to :address
      # asserts that a state id exsists in the address string
      assert_match(/\b[A-Z]{2}/, customer.address)
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      # arrange
      # NO arrange needed here calling data from csv in customer.rb
      # act
      Grocery::Customer.all
      # assert
      Grocery::Customer.all.must_be_kind_of Array

      # Useful checks might include:
      #   - Customer.all returns an array
      #   - Everything in the array is a Customer
      #   - The number of customers is correct
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      # Feel free to split this into multiple tests if needed
    end

    it "returns the correct number of customers" do
      # arrange
      # No arrange needed
      # act
      Grocery::Customer.all
      #assert
      Grocery::Customer.all.length.must_equal 35
    end

    it "returns accurate information about the first order" do
      # arrange
      # No arrange needed
      # act
      Grocery::Customer.all
      #assert
      Grocery::Customer.all[0].id.must_equal "1"
      Grocery::Customer.all[0].email.must_equal "leonard.rogahn@hagenes.org"
      Grocery::Customer.all[0].address.must_equal "71596 Eden Route,Connellymouth,LA,98872-9105"
    end

    it "returns accurate information about the last order" do
      # arrange
      # No arrange needed
      # act
      Grocery::Customer.all
      #assert
      Grocery::Customer.all[-1].id.must_equal "35"
      Grocery::Customer.all[-1].email.must_equal "rogers_koelpin@oconnell.org"
      Grocery::Customer.all[-1].address.must_equal "7513 Kaylee Summit,Uptonhaven,DE,64529-2614"

    end
  end

  xdescribe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # TODO: Your test code here!
    end

    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!
    end

    it "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!
    end
  end
end
