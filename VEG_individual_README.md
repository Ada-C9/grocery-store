
                                GROCERY STORE PROJECT


    PROJECT ASSIGNED:
                        18-2-14 PM
    PROJECT DUE:
                        18-2-20 AM (by 8:50 a.m.) (Wave 3)


    PROJECT REQUIREMENTS:  

                              ACTIVE CODE


    WAVE I:     (Due Thursday, 18-2-15; not as a commit)

              A.  Create a Grocery module, such that:

                        YUP

                  1.    It contains a class called Order

                        YUP

                  2.    It contains all future grocery store logic

              B.   Create an Order class, such that:

                  1.    It complies with a.i., above.

                        YUP

                  2.    NEW INSTANCES HAVE:  

                        a.  An ID attribute that:

                          YUP

                            i.  Is read-only

                            YUP - code

                            ii.  Uses the proper helper method

                            YUP

                        b.  A PRODUCTS ATTRIBUTE to hold a collection of
                            products, such that:

                            i.  The correct helper method is used:

                                YUP

                            ii.  THE COLLECTION AS A WHOLE:  

                                I.  Is allowed to contain zero products

                                YUP -- CODE + TEST

                            iii.  MEMBERS OF THE COLLECTION

                                I.  Are unique
                                    (i.e, there is only one of each kind of product)

                                II. Have prices  


                  3.     Its METHODS include:

                         a.  A -TOTAL- method, that does:  

                                YUP

                             i.  MECHANIC 1:  Math:

                                  I.  Takes the sum of the prices of items in a given order
                                      (i.e., subtotal)

                                      YUP

                                 II.  Adds 7.5% sales tax to the subtotal.

                                      YUP

                              ii. MECHANIC 2:  Rounding:  

                                  I.  Rounds return value to 2 decimal places

                                      VEG COMMENT:  This is a fanciness opportunity!
                                          SUBSEQUENT:  Nope, actually, because
                                                      we're coding to the test.

                                      YUP

                          b.  An -ADD PRODUCT- method that:  

                              i.  Takes 2 PARAMETERS:  

                                  I.  Product name

                                        YUP

                                  II. Product price

                                        YUP

                              ii. MECHANICS:  

                                  I.  Adds the product/price pairs to the product list

                                      (see B.2.b., above)

                                        YUP

                                  II. Returns a value of "TRUE" when the pair is added.

                                        YUP

                          c.  A -REMOVE PRODUCT- method that:

                                  YUP

                                 I.  Takes a SINGLE PARAMETER:

                                      A.  (That being Product Name)

                                 II.  MECHANICS:  

                                      A.  Removes the product from the collection

                                      B.  Returns TRUE if the product has been successfully removed.

                                II.  TESTS  

                                      A.  An appropriate suite of tests.


                                PART TWO:  TESTS  


    WAVE II:   (Due at same time as Wave 3)  


  0.  CSV-WRANGLING:  

    1.  Convert the CSV into an array, and then use that array to generate 100 instances of Order, which will then be stored in an array()

  A.  TESTING:  

    1.  Using the test stubs in order_spec.rb:

      a.  Fill in the test stubs that have already been provided for you

      b.  Get these tests to pass. You should run the tests regularly alongside the code you are writing in the Order class itself.

  A. ACTIVE CODE:

    1.  Update the Order class to be able to handle all of the fields from the CSV file used as input.

        a. To try it out:

            i.  Manually choose the data from the first line of the CSV File



            ii. Make sure you can create a new instance of your Order using that data.

VEG'S OWN NOTES ON WHAT HAS TO HAPPEN HERE:  

(1)  Open the CSV file and read it into an appropriate data structure
(2)  From that data structure, turn each order
      (aka line) in the CSV into an instance of Order, and store them in an array
      called all_orders
        -- Turning lines into order instances--
            a.  lines will have 2 fields, one an ID field and one the field that contains the orders
            b.   Each line has to be turned into an array that contains:
                  1. the ID at index 0
                  2. A hash of products and prices at index 1
            c.   This needs to be stored in an array of arrays that the new method,
                  Self.all, can read to generate new orders, which are then stored in an
                  array of instances of Orders.  





        b. Modifications to order:  

            i.  class methods:

                I.  To add:

                    A.  self.all ---

                        (referred to in 18-2-16 am clarifying lecture as
                          Order.all)

                        1.  Returns: a collection of order instances,
                            representing all the Orders described in the CSV

                                -- Notes from 18-2-16 am clarifying lecture
                                    -- reads from the CSV
                                        -- will get a string of orders and
                                           prices
                                    -- needs to split up a string to create
                                       a hash of orders and prices
                                       -- Restating:  You have to break up
                                          the second field in each row into
                                          a hash of products
                                    -- will probably use ???.split???
                                    -- When you test Order.all:
                                        --  Need to call Order.all and get the
                                            list
                                        --  Test the number of orders
                                        --  Test whether you're getting an
                                            array
                                        --  Test whether what you have are
                                            instances of Order  
                                            -- Will probably need to loop
                                               through the file to test all
                                               elements  
                                           --  Test to make sure first order
                                               and last order are right
                                                  -- Make sure attributes have
                                                     the right values  

                        2.   Notes:

                          A.  From the READMEs:

                              a.  To parse the product string from the CSV
                                  you will need to use the split method.

                              b.  CSV file specs:   

                                  The data consists of:

                                  I.  ID (an integer) -- a unique identifier--
                                  II, PRODUCT (strings):
                                      The list of products in the following format:      
                                            name:price;nextname:nextprice

                            B. From 18-2-16 am clarifying lecture

                                i.   reads from the CSV
                                ii.   will get a string of orders and prices
                                      a.  Needs to split up that string to create
                                       a hash of orders and prices
                                                   -- Restating:  You have to break up
                                                      the second field in each row into
                                                      a hash of products
                                                -- will probably use ???.split???
                                                -- When you test Order.all:
                                                    --  Need to call Order.all and get the
                                                        list
                                                    --  Test the number of orders
                                                    --  Test whether you're getting an
                                                        array
                                                    --  Test whether what you have are
                                                        instances of Order  
                                                        -- Will probably need to loop
                                                           through the file to test all
                                                           elements  
                                                       --  Test to make sure first order
                                                           and last order are right
                                                              -- Make sure attributes have
                                                                 the right values                        


                    B.  self.find(id) -

                        1.  Returns:  an instance of Order where the value of the id field in the CSV matches the passed parameter.

                        2. Notes from 18-2-16 am clarifying lecture:
                                  -- Takes one parameter (an ID)
                                  -- Returns one order from the CSV with the
                                     given ID
                                     -- Testing:  
                                        -- Should return nil if it can't
                                           find the given ID.

              II. Determine if the data structure used in Wave 1 will still
                  work

            III.  CSV handling:  

                  A. Appropriately parse the product data from CSV file in Order.all
                  B. Use CSV library only in Order.all (not in Order.find)
                  C. Use Order.all to get order list in Order.find



            IV.  Error Handling:  

                A.  Determine what should your program do if Order.find
                    is called with an ID that doesn't exist.

WAVE III:  

    Clarifying lecture 18-2-16:
        --  the class Online Order will inherit from Orders
        -- Online Order will have overwritten methods as described in the
           assignment  
