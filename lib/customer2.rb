require 'csv'

module GroceryTwo
  class CustomerTwo
    attr_reader :id, :email, :street, :city, :state, :zip_code

    @@all_customers = []

    protected

    def initialize(customer_hash)
      @id = customer_hash[:id].to_i
      @email = customer_hash[:email]
      @street = customer_hash[:street]
      @city = customer_hash[:city]
      @state = customer_hash[:state]
      @zip_code = customer_hash[:zip_code]
    end


    def self.all
      if @@all_customers.empty? # TODO: uncomment these when done!!
        CSV.read("../support/customers3.csv", headers: true, header_converters:
          :symbol).each do |line|
            @@all_customers << GroceryTwo::CustomerTwo.new(line)
        end
      end
      # puts @@all_customers.inspect
      return @@all_customers

    end

    #
    def self.find(requested_id)
      # puts all.inspect
      return GroceryTwo::CustomerTwo.all.find { |customer| customer.id == requested_id }
      # return all.find { |customer| customer.id == requested_id }
    end

    private

    # def self.force_update
    #   @@all_customers = []
    #   GroceryTwo::CustomerTwo.all
    # end


  end
end

module GroceryTwo
  class NewCustomerTwo < GroceryTwo::CustomerTwo

    # public_class_method :new

    def initialize(customer_hash)
      super(customer_hash)
      add_new_customer(customer_hash)
    end

    private

    def add_new_customer(customer_hash)
      if GroceryTwo::CustomerTwo.find(@id).nil?
        CSV.open("../support/customers3.csv", "a", headers: true,
          header_converters: :symbol) do |file|
            file << [@id, @email, @street, @city, @state, @zip_code]
        end
        @@all_customers << self
        # @@all_customers = []
        # GroceryTwo::CustomerTwo.all
        # GroceryTwo::CustomerTwo.force_update
      end
    end

  end
end

# puts
# puts "ALL initial:"
# puts GroceryTwo::CustomerTwo.all.inspect
# puts "-" * 30
# puts
# test_customer = GroceryTwo::NewCustomerTwo.new({id: 42, email: "adalovelace.gmail.com",
#   street: "42 Baker Street", city: "Seattle", state: "WA", zip_code: "98101-1820"})
#   puts "-" * 30
#   puts
#
# puts   test_customer.id
# # puts GroceryTwo::CustomerTwo.new({id: 44, email: "dgdg.gmail.com",
# #   street: "jkl", city: "3", state: "22", zip_code: "10"})
# puts "-" * 30
# puts
# GroceryTwo::NewCustomerTwo.new({id: 42, email: "dgdg.gmail.com",
#   street: "jkl", city: "3", state: "22", zip_code: "10"})
#   puts "-" * 30
#
# puts
# puts GroceryTwo::NewCustomerTwo.find(42).inspect
# puts
# puts "-" * 30
# puts
# puts GroceryTwo::NewCustomerTwo.find(44).inspect
# puts
# puts "-" * 30
# puts
# puts GroceryTwo::CustomerTwo.all.inspect
