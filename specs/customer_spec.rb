require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'
require 'csv'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 111
      email = "ada@adadev.org"
      address = "1215 4th Avenue"
      city = "Seattle"
      state = "WA"
      zip = "98161"
      customer = Grocery::Customer.new(id, email, address, city, state, zip)

      customer.must_be_instance_of Grocery::Customer

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal email
      customer.email.must_be_kind_of String

      customer.must_respond_to :address
      customer.address.must_equal address
      customer.address.must_be_kind_of String

      customer.must_respond_to :city
      customer.city.must_equal city
      customer.city.must_be_kind_of String

      customer.must_respond_to :state
      customer.state.must_equal state
      customer.state.must_be_kind_of String

      customer.must_respond_to :zip
      customer.zip.must_equal zip
      customer.zip.must_be_kind_of String

    end
  end

  describe "Customer.all" do
    CSV.open('some.csv', 'w+') do |csv|
      csv << ["1","leonard.rogahn@hagenes.org","71596 Eden Route","Connellymouth","LA","98872-9105"]
      csv << ["2","ruben_nikolaus@kreiger.com","876 Kemmer Cove","East Luellatown","AL","21362"]
      csv << ["3","edison.mclaughlin@hyattjohns.co","96807 Cartwright Points","North Casper","MT","29547"]
      csv << ["4","cameron_kozey@littlejenkins.net","24030 Mariah Ranch","Wolfbury","TN","41203-5262"]
    end
    customers = Grocery::Customer.all('some.csv')

    it "Returns an array of all customers" do
      customers.must_be_kind_of Array
      customers.length.must_equal 4
      customers.each do |customer|
        customer.must_be_instance_of Grocery::Customer
      end
    end

    it "Returns accurate information about the first customer" do
      customers.first.id.must_equal 1
      customers.first.email.must_equal "leonard.rogahn@hagenes.org"
      customers.first.address.must_equal "71596 Eden Route"
      customers.first.city.must_equal "Connellymouth"
      customers.first.state.must_equal "LA"
      customers.first.zip.must_equal "98872-9105"
    end

    it "Returns accurate information about the last customer" do
      customers.last.id.must_equal 4
      customers.last.email.must_equal "cameron_kozey@littlejenkins.net"
      customers.last.address.must_equal "24030 Mariah Ranch"
      customers.last.city.must_equal "Wolfbury"
      customers.last.state.must_equal "TN"
      customers.last.zip.must_equal "41203-5262"
    end
  end

  describe "Customer.find" do
    CSV.open('some.csv', 'w+') do |csv|
      csv << ["1","leonard.rogahn@hagenes.org","71596 Eden Route","Connellymouth","LA","98872-9105"]
      csv << ["2","ruben_nikolaus@kreiger.com","876 Kemmer Cove","East Luellatown","AL","21362"]
      csv << ["3","edison.mclaughlin@hyattjohns.co","96807 Cartwright Points","North Casper","MT","29547"]
      csv << ["4","cameron_kozey@littlejenkins.net","24030 Mariah Ranch","Wolfbury","TN","41203-5262"]
    end

    it "Can find the first customer from the CSV" do
      first_customer = Grocery::Customer.find(1,'some.csv')

      first_customer.must_be_instance_of Grocery::Customer
      first_customer.id.must_equal 1
      first_customer.email.must_equal "leonard.rogahn@hagenes.org"
    end

    it "Can find the last customer from the CSV" do
      last_customer = Grocery::Customer.find(4,'some.csv')

      last_customer.id.must_equal 4
      last_customer.email.must_equal "cameron_kozey@littlejenkins.net"
    end

    it "Returns nil for a customer that doesn't exist" do
      Grocery::Customer.find(5,'some.csv').must_be_nil
    end
  end
end
