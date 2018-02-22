require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

Minitest::Reporters.use!

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do

  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!

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
      # TODO: Your test code here!
      # Arrange
      last_email="rogers_koelpin@oconnell.org"
      last_id = 35
      first_email="leonard.rogahn@hagenes.org"
      first_address={:street=>"71596 Eden Route",
        :city=>"Connellymouth", :state=>"LA", :zip=>"98872-9105"}

        #Act
      customer = Grocery::Customer.all
      first_customer = customer[0]
      last_customer = customer[-1]
      # Assert
      customer = Grocery::Customer.all
      customer.must_be_instance_of Array

      first_customer.id.must_equal 1
      first_customer.email.must_equal  first_email
      first_customer.address.must_equal  first_address
      last_customer.id.must_equal  last_id
      last_customer.email.must_equal last_email
      end
    end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # TODO: Your test code here!
      # Arrange

      # Act
      first_customer = Grocery::Customer.find(1)
      # Assert
      first_customer.id.must_equal 1
      first_customer.email.must_equal "leonard.rogahn@hagenes.org"
      first_customer.address.must_equal({:street=>"71596 Eden Route",
        :city=>"Connellymouth", :state=>"LA", :zip=>"98872-9105"})

    end

    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!
      # Arrange
      last_id = 35
      last_email = "rogers_koelpin@oconnell.org"
      # Act
      last_customer = Grocery::Customer.find(35)
      # Assert
      last_customer.id.must_equal last_id
      last_customer.email.must_equal last_email
    end

    it "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!
      # Arrange
      #id = 45
      # Act
      #customer = Grocery::Customer.find(45)
      # Assert
      proc{Grocery::Customer.find(45)}.must_raise ArgumentError
    end
  end
end
