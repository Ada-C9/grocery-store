require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'
require 'csv'

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'

xdescribe "Customer" do
  let(:all) {Grocery::Customer.all}
  let(:find) {Grocery::Customer.find(19)}

let(:first_customer) {Grocery::Customer.new(1,"leonard.rogahn@hagenes.org", "71596 Eden Route, Connellymouth, LA, 98872-9105")}

let(:last_customer) {Grocery::Customer.new(35,"rogers_koelpin@oconnell.org", "7513 Kaylee Summit, Uptonhaven, DE, 64529-2614" )}

  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.must_respond_to :address
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - Customer.all returns an array
      #   - Everything in the array is a Customer
      #   - The number of orders is correct
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      # Feel free to split this into multiple tests if needed
      all.must_be_instance_of Array
      all.length.must_equal 35
      all.each { |customer| order.must_be_instance_of Grocery::Customer }
    end

    it "Returns accurate information about the first customer" do
      # TODO: Your test code here!
      all[0].id.must_equal 1
      all[0].email.must_equal first_order.email
      all[0].address.must_equal first_order.address
    end

    it "Returns accurate information about the last customer" do
      # TODO: Your test code here!
      all[-1].id.must_equal 35
      all[-1].email[name].must_equal last_order.email
      all[-1].address[name].must_equal last_order.address
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # TODO: Your test code here!
      Grocery::Customer.find(1).must_be_instance_of Grocery::Customer
      Grocery::Customer.find(1).id.must_equal first_order.id
      Grocery::Customer.find(1).email.must_equal first_order.email
      Grocery::Customer.find(1).address.must_equal first_order.address
    end

    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!
      Grocery::Customer.find(35).must_be_instance_of Grocery::Customer
      Grocery::Customer.find(35).id.must_equal first_order.id
      Grocery::Customer.find(35).email.must_equal first_order.email
      Grocery::Customer.find(35).address.must_equal first_order.address
    end

    it "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!
      proc { Grocery::Customer.find(101) }.must_raise ArgumentError
    end
  end
end
