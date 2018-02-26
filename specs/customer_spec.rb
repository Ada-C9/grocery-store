# require 'minitest/autorun'
# require 'minitest/reporters'
# require 'minitest/skip_dsl'
#
# # TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'
#
# describe "Customer" do
#   describe "#initialize" do
#     it "Takes an ID, email and address info" do
#       id = 384
#       email = "mary@ada.org"
#       address = "626 Malden Ave"
#
#       customer1 = Grocery::Customer.new(384, "mary@ada.org", "626 Malden Ave")
#       customer1.must_respond_to :id
#       customer1.id.must_equal id
#       customer1.id.must_be_kind_of Integer
#
#       customer1.must_respond_to :email
#       customer1.email.must_equal email
#
#       customer1.must_respond_to :address
#       customer1.address.must_equal address
#     end
#   end
#
#   describe "Customer.all" do
#     it "Returns an array of all customers" do
#       # TODO: Your test code here!
#
#       # Useful checks might include:
#       #   - Customer.all returns an array
#       #   - Everything in the array is a Customer
#       #   - The number of orders is correct
#       #   - The ID, email address of the first and last
#       #       customer match what's in the CSV file
#       # Feel free to split this into multiple tests if needed
#     end
#   end
#
#   describe "Customer.find" do
#     it "Can find the first customer from the CSV" do
#       # TODO: Your test code here!
#     end
#
#     it "Can find the last customer from the CSV" do
#       # TODO: Your test code here!
#     end
#
#     it "Raises an error for a customer that doesn't exist" do
#       # TODO: Your test code here!
#     end
#   end
# end
