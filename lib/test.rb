# customer = ["1","leonard.rogahn@hagenes.org", "71596 Eden Route", "Connellymouth", "LA", "98872-9105"]
#
#
# customer_objects = []
# # csv.each do |line|
# #   line[2..5].join(',')
# #   customer_objects << line
# # end
#
# a = customer[2..5].join(',')
# customer_objects << a
#
# puts "#{customer[0]}, #{customer[1]},  #{customer_objects}"
#
# #   products_array2 = []
# #   products_array.each do |product|
# #     products_array2 << product.split(':')
# #   end
# #
# #   products_hash = products_array2.to_h
# #   line = Customer.new(line[0], line[1], )
# #   order_objects << line
# # end
# # return order_objects
# #
# # Customer.new(line[0], line[1], )
#

#
# order = ["1","Lobster:17.18;Annatto seed:58.38;Camomile:83.21","25","complete"]
#
# oorder_objects = []
# # CSV.read("support/online_orders.csv").each do |line|
#
#   products_array = order[1].split(';')
#
#   products_array2 = []
#   products_array.each do |product|
#     products_array2 << product.split(':')
#   end
#   products_hash = products_array2.to_h
#   line = Order.new(line[0], products_hash, line[2], line[3].to_sym)
#   order_objects << line
#
# return order_objects
