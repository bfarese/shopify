# Overview

The entire process is encapsulated in the OrderSync Class located in
'app/services/order_sync'.

This class is leveraging 2 different classes:

## [1] EcommerceApi::OrdersByDate
  - located at 'app/services/ecommerce_api/orders_by_date'
  - This class makes the request to the Shopify endpoint to collect all the orders.
  - It takes an optional hash of arguments and using #fetch to find the args or set a
  default value.
  - Environment variables are used for the Shopify key, password, and store url.  The
  variables are hidden from Git through GitIgnore and using the dotenv gem.

## [2] MarketingApi::TrackOrder
  - Located at 'app/services/marketing_api/track_order'
  - Responsible for configuring and executing the Track requests for:
    - [A] An individual order
    - [B] All products associated with order
  - The class accepts a single order as an argument
  - During the initialization of the object, a Registry pattern (Martin Fowler) is used
  to assist with dependency management. The various classes are scoped to the
  MarketingApi module and wrapped in the Registry class to make them "global" to the
  MarketingApi module. The wrapped classes include:
    - [A] MarketingApi::HttpClient - the HTTP client responsible for actually making the
    request to Track API endpoint.
    - [B] MarketingApi::Order - the class responsible for organizing the order properties
    - [C] MarketingApi::Customer - the class responsible for organizing the customer
    properties
    - [D] MarketingApi::Product - the class responsible for organizing all the properties
    for an individual product
  - The request to track the order will only be executed if the 'financial_status' of the
  order is either "paid" or "authorized".  The "pending" status was left out as payments
  can still fail while in this state.
  - After the order request is made in the #track_order method, the
  #track_product_properties_list method iterates over all the product_properties
  and makes a request for each product included in the order

# Additional Models:

## [1] Values
  - These classes are inspired by Ward Cunningham's Whole Value Pattern.
  - The purpose of this pattern is to use Value objects and immutability with the intent
  of making domain objects more error proof when their values are critical.  Money is the
  classic example of needing to use a value object pattern (which is what was required
  here)
  - The classes include:
    - [A] WholeValue - the base class from which all WholeValue objects will inherit from
    - [B] Cents::Cent - the cent object that is at the core of managing money as a value
    object
    - [C] Cents::Cent() - this is a conversion function that is used to filter the
    arguments passed into the Cent class so that the proper value is used in the Cent
    class.
    - [D] ExceptionalValue - this class is used if the proper arguments aren't passed
    to the value object (a different kind of 'error')
    - [E] Blank - used to represent no value in place of using nil as nil can cause lots of
    problems in Ruby code.

## [2] Spec
  - These are the automated tests for the project.
