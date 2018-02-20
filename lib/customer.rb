require 'csv'
# require 'pry'
# require_relative '../lib/valid_checks'


module Grocery
  class Customer
    attr_reader :id, :email, :address

    @@all_customers = [] # stores all customers

    def initialize(initial_id, initial_email, initial_address)
      @id = has_valid_id_or_error(initial_id)
      @email = has_valid_email_or_error(initial_email)
      @address = has_valid_address_or_error(initial_address)
    end

    def self.all
      return get_all_customers
    end

    #
    def self.find(requested_id)
      return find_customer_by_id(requested_id)
    end

    private

    #
    def self.get_all_customers
      build_all_customers if @@all_customers.empty?
      return @@all_customers
    end

    # P
    def self.build_all_customers
      @@all_customers = []
      CSV.read("../support/customers.csv").each do |row|
        id = row[0].to_i
        email = row[1]
        address = get_address_hash(row[2..5])
        @@all_customers << Grocery::Customer.new(id, email, address)
      end
    end

    def self.find_customer_by_id(requested_id)
      return get_all_customers.find { |customer| customer.id == requested_id }
    end

    def self.get_address_hash(address_values)
      address = {}
      Grocery::Customer.get_address_keys.each_with_index { |key, index|
        address[key] = address_values[index] }
      return address
    end

    def self.get_address_keys
        return %i[street city state zip]
    end

    #
    def has_valid_email_or_error(initial_email)
      if initial_email.class != String || !initial_email.match?(/[[:alpha:]+?]@/)
        raise ArgumentError.new("Customer email must be a valid email.")
      end
      return initial_email
    end

    #
    def has_valid_id_or_error(initial_id)
      if initial_id.class != Integer || initial_id < 1
        raise ArgumentError.new("Customer ID must be a number greater than 0.")
      end
      return initial_id
    end

    #
    def has_valid_address_or_error(address)
      if address.class != Hash || address.keys != Grocery::Customer.get_address_keys
        raise ArgumentError.new("Address must be a Hash and complete.")
      end
      return address
    end





  end
end
