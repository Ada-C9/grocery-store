require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      # arrange
      id = 50
      email = "thebatintheman@gmail.com"
      street_address = "200 Cave St."
      city = "Baton Rouge"
      state = "Louisiana"
      zip = "65980"

      # act
      customer = Grocery::Customer.new(id, email, street_address, city, state, zip)

      # assert
      customer.must_respond_to :id
      customer.id.must_be_kind_of Integer
      customer.id.must_equal id
      customer.must_respond_to :email
      customer.email.must_be_kind_of String
      customer.email.must_equal email
      customer.must_respond_to :street_address
      customer.street_address.must_be_kind_of String
      customer.street_address.must_equal street_address
      customer.must_respond_to :city
      customer.city.must_be_kind_of String
      customer.city.must_equal city
      customer.must_respond_to :state
      customer.state.must_be_kind_of String
      customer.state.must_equal state
      customer.must_respond_to :zip
      customer.zip.must_be_kind_of String
      customer.zip.must_equal zip
    end
  end # describe initialize

  describe "Customer.all" do
    it "Returns an array of all customers" do
      # TODO: Your test code here!
      # Useful checks might include:

      #   - Customer.all returns an array
      #   - Everything in the array is a Customer
      #   - The number of orders is correct
      # arrange
      customers_count = 0
      CSV.open("support/customers.csv", "r").each do |customer|
        customers_count += 1
      end

      # act
      customers = Grocery::Customer.all
      customers_right_class = false
      customers.each do |customer|
        if customer.class == Grocery::Customer
          customers_right_class = true
        else
          return customers_right_class = false
        end
      end

      # assert
      customers.must_be_kind_of Array
      customers.length.must_equal customers_count
      customers_right_class.must_equal true
    end

    #   - The ID, email address of the first and last
    #       customer match what's in the CSV file
    it "returns the correct information for the first customer" do
      # arrange
      first_customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", "71596 Eden Route", "Connellymouth", "LA", "98872-9105")

      # act
      customers_array = Grocery::Customer.all
      first_from_array = customers_array[0]

      # assert
      first_from_array.id.must_equal first_customer.id
      first_from_array.email.must_equal first_customer.email
      first_from_array.street_address.must_equal first_customer.street_address
      first_from_array.city.must_equal first_customer.city
      first_from_array.state.must_equal first_customer.state
      first_from_array.zip.must_equal first_customer.zip
    end

    it "returns the correct information for the last customer" do
      # arrange
      last_customer = Grocery::Customer.new(35, "rogers_koelpin@oconnell.org", "7513 Kaylee Summit", "Uptonhaven", "DE", "64529-2614")

      # act
      customers_array = Grocery::Customer.all
      last_from_array = customers_array.last

      # assert
      last_from_array.id.must_equal last_customer.id
      last_from_array.email.must_equal last_customer.email
      last_from_array.street_address.must_equal last_customer.street_address
      last_from_array.city.must_equal last_customer.city
      last_from_array.state.must_equal last_customer.state
      last_from_array.zip.must_equal last_customer.zip
    end
  end # describe Customer.all


  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # TODO: Your test code here!
      first_customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", "71596 Eden Route", "Connellymouth", "LA", "98872-9105")

      # act
      first_customer_found = Grocery::Customer.find(1)

      # assert
      first_customer_found.id.must_equal first_customer.id
      first_customer_found.email.must_equal first_customer.email
      first_customer_found.street_address.must_equal first_customer.street_address
      first_customer_found.city.must_equal first_customer.city
      first_customer_found.state.must_equal first_customer.state
      first_customer_found.zip.must_equal first_customer.zip
      first_customer_found.must_be_instance_of Grocery::Customer
    end

    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!
      last_customer = Grocery::Customer.new(35, "rogers_koelpin@oconnell.org", "7513 Kaylee Summit", "Uptonhaven", "DE", "64529-2614")

      # act
      last_customer_found = Grocery::Customer.find(35)

      # assert
      last_customer_found.id.must_equal last_customer.id
      last_customer_found.email.must_equal last_customer.email
      last_customer_found.street_address.must_equal last_customer.street_address
      last_customer_found.city.must_equal last_customer.city
      last_customer_found.state.must_equal last_customer.state
      last_customer_found.zip.must_equal last_customer.zip
      last_customer_found.must_be_instance_of Grocery::Customer
    end

    it "Returns nil for a customer that doesn't exist" do
      # TODO: Your test code here!
      nonexistent_customer = Grocery::Customer.find(50)

      # assert
      nonexistent_customer.must_be_instance_of NilClass
      nonexistent_customer.must_equal nil
    end
  end
end
