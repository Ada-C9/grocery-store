require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
Minitest::Reporters.use!
require_relative '../lib/customer.rb'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 1234
      email = "rhubarbra@dogworld.com"
      address = "1234 Treat lane Seattle WA 98103"

      roobear = Grocery::Customer.new(id, email, address)

      roobear.must_respond_to :id
      roobear.id.must_equal id
      roobear.id.must_be_kind_of Integer

      roobear.must_respond_to :email
      roobear.email.must_equal email

      roobear.must_respond_to :address
      roobear.address.must_equal address

    end
  end

  describe "Customer.all" do
    # TODO: Your test code here!
    # Useful checks might include:
    #   - The number of orders is correct
    #   - The ID, email address of the first and last
    #       customer match what's in the CSV file

    it "Returns an array of all customers" do
      Grocery::Customer.all.class.must_equal Array
    end
  end

    it "Returns an array of objects of the Customer class" do
      Grocery::Customer.all.each do |customer|
        customer.must_be_instance_of Grocery::Customer
      end
    end

    it "Returns accurate information about the first order" do
      id = 1
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route Connellymouth LA 98872-9105"

      Grocery::Customer.all.first.id.must_equal id
      Grocery::Customer.all.first.email.must_equal email
      Grocery::Customer.all.first.address.must_equal address
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
