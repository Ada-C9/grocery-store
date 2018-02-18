require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      id = 13337
      email = 'this@that.com'
      address1 = '543 1st Street'
      city = "Tucson"
      state = "AZ"
      zipcode = 55545

      customer = Grocery::Customer.new(id, email, address1, city, state, zipcode)

      #checks customer attribute and parameters
      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      #checks email attribute and parameters
      customer.must_respond_to :email
      customer.email.must_equal email
      customer.email.must_be_kind_of String

      #checks address1 attribute and parameters
      customer.must_respond_to :address1
      customer.address1.must_equal address1
      customer.address1.must_be_kind_of String

      #checks city attribute and parameters
      customer.must_respond_to :city
      customer.city.must_equal city
      customer.city.must_be_kind_of String

      #checks state attribute and parameters
      customer.must_respond_to :state
      customer.state.must_equal state
      customer.state.must_be_kind_of String

      #checks zipcode attribute and parameters
      customer.must_respond_to :zipcode
      customer.zipcode.must_equal zipcode
      customer.zipcode.must_be_kind_of Integer
      #customer.zipcode.length.must_equal 5

    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - Customer.all returns an array
      #act
      result = Grocery::Customer.all
      #assert
      #returns an array
      result.must_be_kind_of Array
      # Feel free to split this into multiple tests if needed
    end

    #
    xit 'Everything in the array is a customer' do
      #implement this
    end

    it  'The ID, email address of the first customer  match what is in the CSV file' do
      #Arrange
      id_and_email = []
      first_order_program_id_and_email = []
      #act
      first_order = CSV.open('support/customers.csv', 'r') { |csv| csv.first }

      id_and_email << first_order.instance_variable_get(:@id)
      id_and_email <<first_order.instance_variable_get(:@email)
      #assert
      first_order_program = (Grocery::Customer.all).first

      first_order_program_id_and_email << first_order_program.instance_variable_get(:@id)

      first_order_program_id_and_email <<
      first_order.instance_variable_get(:@email)
      #implement this
      id_and_email.must_equal first_order_program_id_and_email
    end

    it  'The ID, email address of the last customer  match what is in the CSV file' do
      #Arrange
      id_and_email = []
      last_order_program_id_and_email = []
      #act
      last_order = CSV.open('support/customers.csv', 'r').to_a
      last_order[-1] == (Grocery::Customer.all)[-1]

      id_and_email << last_order.instance_variable_get(:@id)
      id_and_email <<last_order.instance_variable_get(:@email)
      #assert
      last_order_program = (Grocery::Customer.all)[-1]

      last_order_program_id_and_email << last_order_program.instance_variable_get(:@id)

      last_order_program_id_and_email <<
      last_order.instance_variable_get(:@email)
      #implement this
      id_and_email.must_equal last_order_program_id_and_email
    end

    it "checks the number of customers is correct" do
      result = Grocery::Customer.all
      customer_info_csv =CSV.read("support/customers.csv", 'r',headers: true).to_a

      result.length.must_equal customer_info_csv.length
    end
  end



  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      first_customer = CSV.open('support/customers.csv', 'r') { |csv| csv.first }

      first_customer == Grocery::Customer.find(1)
    end

    it "Can find the last customer from the CSV" do
      #act
      last_customer = CSV.open('support/customers.csv', 'r').to_a
      #assert
      last_customer[-1] == Grocery::Customer.find(-1)
    end
    #
   it "Raises an error for a customer that doesn't exist" do
     #act
     #id ='a'
     id = 1000000000000
     #id = 0

     #assert
     Grocery::Customer.find(id).must_be_nil
    end
  end

end
