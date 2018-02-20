# module Grocery
#   module ValidChecks
#
#     # Returns 'true' if provided name is a non-empty String with at least one
#     # character. Otherwise, returns 'false'.
#     def is_valid_name?(name)
#       return name.class == String && name.match?(/[[:alpha:]+?]/)
#     end
#
#     def has_valid_name_or_error(name)
#       if !is_valid_name?(name)
#         raise ArgumentError.new("#{name} must be a String and have at least one character")
#       end
#     end
#
#     def has_valid_id_or_error(id, all)
#       if !is_valid_id?(id, all)
#         raise ArgumentError.new("ID must be a unique ID number.")
#       end
#     end
#
#     #
#     def is_valid_id?(id, all)
#       return id.class == Integer && id > 0 && Grocery::ValidChecks.find_by_id(id, all).nil?
#     end
#
#     #
#
#
#     def self.find_by_id(requested_id, all)
#       all.find { |order| order.id == requested_id }
#     end
#
#     # def check_if_hash(initial_products)
#     #   if initial_products.class != Hash
#     #     raise ArgumentError.new("Products must be a Hash.")
#     #   end
#     # end
#
#   end
# end
