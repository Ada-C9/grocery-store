require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

Minitest::Reporters.use!

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      id = 23
      email = "someone@someplace.com"
      address_1 = "1234 Some Road Ave"
      city = "Sometown"
      state = "SP"
      zip_code = "12345"

      customer = Grocery::Customer.new(id, email, address_1, city, state, zip_code)

      customer.class.must_equal Grocery::Customer

      customer.must_respond_to :id
      customer.id.must_equal 23
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal email

      customer.must_respond_to :address_1
      customer.address_1.must_equal address_1

      customer.must_respond_to :city
      customer.city.must_equal city

      customer.must_respond_to :state
      customer.state.must_equal state

      customer.must_respond_to :zip_code
      customer.zip_code.must_equal zip_code
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
      all_customers = Grocery::Customer.all
      total_customers = all_customers.length

      total_customers.must_equal 35
      all_customers.class.must_equal Array
      all_customers.each do |customer|
        customer.class.must_equal Grocery::Customer
      end
    end
    it "returns accurate information about the first customer" do
      id = 1
      email = "leonard.rogahn@hagenes.org"
      address_1 = "71596 Eden Route"
      city = "Connellymouth"
      state = "LA"
      zip_code = "98872-9105"

       all_customers = Grocery::Customer.all
       first_customer = all_customers[0]

       first_customer.id.must_equal id
       first_customer.email.must_equal email
       first_customer.address_1.must_equal address_1
       first_customer.city.must_equal city
       first_customer.state.must_equal state
       first_customer.zip_code.must_equal zip_code
   end

    it "returns accurate information about the last customer" do
      id = 35
      email = "rogers_koelpin@oconnell.org"
      address_1 = "7513 Kaylee Summit"
      city = "Uptonhaven"
      state = "DE"
      zip_code = "64529-2614"

      all_customers = Grocery::Customer.all
      last_customer = all_customers.last

      last_customer.id.must_equal id
      last_customer.email.must_equal email
      last_customer.address_1.must_equal address_1
      last_customer.city.must_equal city
      last_customer.state.must_equal state
      last_customer.zip_code.must_equal zip_code
    end
  end

  describe "Customer.find" do
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
