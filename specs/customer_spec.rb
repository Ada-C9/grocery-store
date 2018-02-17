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
      # assert_match(/\b[A-Z]{2}/, customer.address)

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
      # Grocery::Customer.all[0].address.must_equal "71596 Eden Route,Connellymouth,LA,98872-9105"
      Grocery::Customer.all[0].address[:street].must_equal "71596 Eden Route"
      Grocery::Customer.all[0].address[:city].must_equal "Connellymouth"
      Grocery::Customer.all[0].address[:state].must_equal "LA"
    end

    it "returns accurate information about the last order" do
      # arrange
      # No arrange needed
      # act
      Grocery::Customer.all
      #assert
      Grocery::Customer.all[-1].id.must_equal "35"
      Grocery::Customer.all[-1].email.must_equal "rogers_koelpin@oconnell.org"
      # Grocery::Customer.all[-1].address.must_equal "7513 Kaylee Summit,Uptonhaven,DE,64529-2614"
      Grocery::Customer.all[-1].address[:street].must_equal "7513 Kaylee Summit"
      Grocery::Customer.all[-1].address[:city].must_equal "Uptonhaven"
      Grocery::Customer.all[-1].address[:state].must_equal "DE"
    end

    it "returns address as a hash of a hash" do
      # arrange
      # No arrange needed
      # act
      Grocery::Customer.all
      #assert
      Grocery::Customer.all[0].address.must_be_kind_of Hash
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # arrange
      # No arrange needed
      # act
      Grocery::Customer.find("first")
      #assert
      Grocery::Customer.find("first").id.must_equal Grocery::Customer.all[0]
      Grocery::Customer.find("first").email.must_equal Grocery::Customer.all[0].email
      Grocery::Customer.find("first").address[:street].must_equal Grocery::Customer.all[0].address[:street]
      Grocery::Customer.find("first").address[:city].must_equal Grocery::Customer.all[0].address[:city]
      Grocery::Customer.find("first").address[:state].must_equal Grocery::Customer.all[0].address[:state]
    end

    it "Can find the last customer from the CSV" do
      # arrange
      # No arrange needed
      # act
      Grocery::Customer.find("last")
      #assert
      Grocery::Customer.find("last").id.must_equal "last"
      Grocery::Customer.find("last").email.must_equal "leonard.rogahn@hagenes.org"
      Grocery::Customer.find("last").address[:street].must_equal "71596 Eden Route"
      Grocery::Customer.find("last").address[:city].must_equal "Connellymouth"
      Grocery::Customer.find("last").address[:state].must_equal "LA"
    end

    it "Can find the customer from the CSV by id" do
      # arrange
      # No arrange needed
      # act
      Grocery::Customer.find("1")
      #assert
      Grocery::Customer.find("1").id.must_equal Grocery::Customer.all[0]
      Grocery::Customer.find("1").email.must_equal Grocery::Customer.all[0].email
      Grocery::Customer.find("1").address[:street].must_equal Grocery::Customer.all[0].address[:street]
      Grocery::Customer.find("1").address[:city].must_equal Grocery::Customer.all[0].address[:city]
      Grocery::Customer.find("1").address[:state].must_equal Grocery::Customer.all[0].address[:state]
    end

    it "Raises an error for a customer that doesn't exist" do
      #arrange
      # N/A
      # act
      Grocery::Customer.find("500")
      # assert
      Grocery::Customer.find("500").must_equal nil
    end
  end
end
