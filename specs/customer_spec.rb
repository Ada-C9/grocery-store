require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'



describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do

      new_customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", "71596 Eden Route, Connellymouth, LA, 98872-9105")

      # ID:
      new_customer.must_respond_to :costumer_id
      new_customer.costumer_id.must_equal 1
      new_customer.costumer_id.must_be_kind_of Integer

      # Email:
      new_customer.must_respond_to :email
      new_customer.email.must_equal "leonard.rogahn@hagenes.org"

      # Address:
      new_customer.must_respond_to :address
      new_customer.address.must_equal "71596 Eden Route, Connellymouth, LA, 98872-9105"
    end
  end
end

describe "Customer.all" do
  it "Returns an array of all customers" do
    # Customer.all returns an array:
    all_customers = Grocery::Customer.all
    all_customers.must_be_kind_of Array

    # Everything in the array is a Customer:
    all_customers[0].must_be_kind_of Grocery::Customer
  end

  it "Confirms the right amount of costumers:" do
    # The number of costumers is correct:
    all_customers = Grocery::Customer.all
    file_customers = CSV.read('support/customers.csv', 'r')
    all_customers.size.must_equal file_customers.size
  end
end

describe "Customer.find" do
  it "Can find the first customer from the CSV" do

    all_customers = Grocery::Customer.all
    find_customer = Grocery::Customer.find(1)

    all_customers[0].must_equal find_customer
  end

  it "Can find the last customer from the CSV" do

    all_customers = Grocery::Customer.all
    find_customer = Grocery::Customer.find(all_customers.size)

    all_customers.last.must_equal find_customer
  end

  it "Raises an error for a customer that doesn't exist" do

    all_customers = Grocery::Customer.all
    proc {Grocery::Customer.find(9999)}.must_raise ArgumentError

  end
end
