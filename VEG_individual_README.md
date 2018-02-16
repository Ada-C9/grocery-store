
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

                        b.  A collection of products, such that:

                              YUP -- code + test

                            i.  THE COLLECTION AS A WHOLE:  

                                I.  Is allowed to contain zero products

                                YUP -- CODE + TEST

                            ii.  MEMBERS OF THE COLLECTION

                                I.  Are unique
                                    (i.e, there is only one of each kind of product)

                                II. Have prices  

                            iii. VEG'S PRELIMINARY THOUGHTS:  

                                  -- Given B.3.b.ii., below, this might be good as
                                     an array of hashes, where each hash contains a single pair.

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

  TEST REQUIREMENTS:  

        1.   Tests to use:  

              A.  Use the suite of tests provided.  

                  *  initialize -- AYE
                  *  add_product -- AYE
                  *  total -- AYE


              B.  Write new tests for the REMOVE_PRODUCT method.

                  * remove_product tests:

                    - Decreases the number of products
                    - returns FALSE if the product is still present
                    -

        2.    To run tests:  

              A.  Run tests from the command line using the 'Rake' command;

              B.  All tests provided should be passing at the end
                  of your work on Wave 1.
