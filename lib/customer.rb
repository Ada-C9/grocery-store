require 'csv'

# This program creates a new Customer.
module Grocery
  class Customer
    attr_reader :id, :email, :address

    @@all_customers = [] # stores all customers

    def initialize(initial_id, initial_email, initial_address)
      @id = has_valid_id_or_error(initial_id) # stores customer id
      @email = has_valid_email_or_error(initial_email)  # stores email address
      @address = has_valid_address_or_error(initial_address) # store address info
    end

    # Returns all customers.
    def self.all
      return get_all_customers
    end

    # Returns customer with the id that matches provided requested_id. If there
    # is no customer with requested_id, returns nil.
    def self.find(requested_id)
      return find_customer_by_id(requested_id)
    end

    private

    # Returns a list of all customers.
    def self.get_all_customers
      build_all_customers if @@all_customers.empty?
      return @@all_customers
    end

    # Creates a list all the customers from the stored CSV file.
    def self.build_all_customers
      @@all_customers = [] # Hard reset of list
      CSV.read('../support/customers.csv').each do |row|
        id = row[0].to_i
        email = row[1]
        address = get_address_hash(row[2..5])
        @@all_customers << Grocery::Customer.new(id, email, address)
      end
    end

    # Returns the customer with the same id number as provided requested_id. If
    # not customer has the requested_id, returns 'nil'.
    def self.find_customer_by_id(requested_id)
      return get_all_customers.find { |customer| customer.id == requested_id }
    end

    # Populates address using the provided address_values,
    def self.get_address_hash(address_values)
      address = {}
      Grocery::Customer.get_address_keys.each_with_index do |key, index|
        address[key] = address_values[index]
      end
      return address
    end

    # Returns the address fields.
    def self.get_address_keys
      return %i[street city state zip]
    end

    # Throw ArgumentError if provided initial_email is not a String or if it
    # does not have at least one character and an '@' sign. Otherwise, returns
    # initial_email.
    def has_valid_email_or_error(initial_email)
      if initial_email.class != String || !initial_email.match?(/[[:alpha:]+?]@/)
        raise ArgumentError.new("Customer email must be a valid email.")
      end
      return initial_email
    end

    # Throw ArgumentError if initial_id is not an Integer or if it has a value
    # less than 1. Otherwise, return initial_id.
    def has_valid_id_or_error(initial_id)
      if initial_id.class != Integer || initial_id < 1
        raise ArgumentError.new("Customer ID must be a number greater than 0.")
      end
      return initial_id
    end

    # Throw ArgumentError if address is not a Hash or if it does not have valid
    # keys for a customer's address.
    def has_valid_address_or_error(address)
      if address.class != Hash || address.keys != Grocery::Customer.get_address_keys
        raise ArgumentError.new("Address must be a Hash and have valid keys.")
      end
      return address
    end

  end
end
