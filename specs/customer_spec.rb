require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
 require_relative '../lib/customer'
# TODO: uncomment the next line once you start wave 3


describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      initialize_test = Grocery::Customer.new('203','selamawit@adaacademy.org','some place Seattle WA 98125')
      initialize_test.id.must_equal('203')
      initialize_test.email.must_equal('selamawit@adaacademy.org')
      initialize_test.address.must_equal('some place Seattle WA 98125')
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      all_array = Grocery::Customer.all
      all_array.class.must_equal(Array)
      #confirm each value read in from CSV is stored as an object from Customer class.
      all_array.each do |a_customer|
        a_customer.must_be_instance_of Grocery::Customer
      end

      all_array.length.must_equal 35
      all_array[0].id.must_equal('1')
      all_array[0].email.must_equal('leonard.rogahn@hagenes.org')
      all_array[0].address.must_equal('71596 Eden Route Connellymouth LA 98872-9105')

    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      customers = Grocery::Customer.all
      test_value = Grocery::Customer.find('1')
      test_value.id.must_equal('1')
    end

    it "Can find the last customer from the CSV" do
      customers = Grocery::Customer.all
      test_value = Grocery::Customer.find('35')
      test_value.id.must_equal('35')
    end

    it "Raises an error for a customer that doesn't exist" do
      customers = Grocery::Customer.all
      test_value_num = Grocery::Customer.find(25)
      test_value_num.must_be_nil

      test_value_out_of_range = Grocery::Customer.find('36')
      test_value_out_of_range.must_be_nil

    end
  end
end
