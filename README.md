## Instructions

* Fork this Repository
* Clone your forked repo to your computer.
* Complete the activity below.
* Push your solution to your forked repo
* Submit a pull request from your repository to this repository
  * Put your name in your PR!

## Iteration 1 - Items & Vendors

```markdown
There are **4** Possible Methods in Iteration 1:
1. Item Creation - including all attr_readers
2. Vendor Creation - including all attr_readers
3. Vendor #check_stock
4. Vendor #stock
```

The Market will need to keep track of its Vendors and their Items. Each Vendor will be able to report its total inventory, stock items, and return the quantity of items. Any item not in stock should return `0` by default.

Use TDD to create a `Vendor` class that responds to the following interaction pattern:

```ruby
pry(main)> require './lib/item'
#=> true

pry(main)> require './lib/vendor'
#=> true

pry(main)> item1 = Item.new({name: 'Peach', price: "$0.75"})
#=> #<Item:0x007f9c56740d48...>

pry(main)> item2 = Item.new({name: 'Tomato', price: '$0.50'})
#=> #<Item:0x007f9c565c0ce8...>

pry(main)> item2.name
#=> "Tomato"

pry(main)> item2.price
#=> 0.5

pry(main)> vendor = Vendor.new("Rocky Mountain Fresh")
#=> #<Vendor:0x00007f85683152f0...>

pry(main)> vendor.name
#=> "Rocky Mountain Fresh"

pry(main)> vendor.inventory
#=> {}

pry(main)> vendor.check_stock(item1)
#=> 0

pry(main)> vendor.stock(item1, 30)

pry(main)> vendor.inventory
#=> {#<Item:0x007f9c56740d48...> => 30}

pry(main)> vendor.check_stock(item1)
#=> 30

pry(main)> vendor.stock(item1, 25)

pry(main)> vendor.check_stock(item1)
#=> 55

pry(main)> vendor.stock(item2, 12)

pry(main)> vendor.inventory
#=> {#<Item:0x007f9c56740d48...> => 55, #<Item:0x007f9c565c0ce8...> => 12}
```

## Iteration 2 - Market and Vendors

```markdown
There are **5** Possible Methods in Iteration 2:
1. Market Creation - including all attr_readers
3. Market #add_vendor
4. Market #vendor_names
5. Market #vendors_that_sell
6. Vendor #potential_revenue
```

A Vendor will be able to calculate their `potential_revenue` - the sum of all their items' price * quantity.

A Market is responsible for keeping track of Vendors. It should have a method called `vendor_names` that returns an array of all the Vendor's names.

Additionally, the Market should have a method called `vendors_that_sell` that takes an argument of an item. It will return a list of Vendors that have that item in stock.

Use TDD to create a `Market` class that responds to the following interaction pattern:

```ruby
pry(main)> require './lib/item'
#=> true

pry(main)> require './lib/vendor'
#=> true

pry(main)> require './lib/market'
#=> true

pry(main)> market = Market.new("South Pearl Street Farmers Market")    
#=> #<Market:0x00007fe134933e20...>

pry(main)> market.name
#=> "South Pearl Street Farmers Market"

pry(main)> market.vendors
#=> []

pry(main)> vendor1 = Vendor.new("Rocky Mountain Fresh")
#=> #<Vendor:0x00007fe1348a1160...>

pry(main)> item1 = Item.new({name: 'Peach', price: "$0.75"})
#=> #<Item:0x007f9c56740d48...>

pry(main)> item2 = Item.new({name: 'Tomato', price: "$0.50"})
#=> #<Item:0x007f9c565c0ce8...>

pry(main)> item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
#=> #<Item:0x007f9c562a5f18...>

pry(main)> item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
#=> #<Item:0x007f9c56343038...>

pry(main)> vendor1.stock(item1, 35)    

pry(main)> vendor1.stock(item2, 7)    

pry(main)> vendor2 = Vendor.new("Ba-Nom-a-Nom")    
#=> #<Vendor:0x00007fe1349bed40...>

pry(main)> vendor2.stock(item4, 50)    

pry(main)> vendor2.stock(item3, 25)

pry(main)> vendor3 = Vendor.new("Palisade Peach Shack")    
#=> #<Vendor:0x00007fe134910650...>

pry(main)> vendor3.stock(item1, 65)  

pry(main)> market.add_vendor(vendor1)    

pry(main)> market.add_vendor(vendor2)    

pry(main)> market.add_vendor(vendor3)

pry(main)> market.vendors
#=> [#<Vendor:0x00007fe1348a1160...>, #<Vendor:0x00007fe1349bed40...>, #<Vendor:0x00007fe134910650...>]

pry(main)> market.vendor_names
#=> ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]

pry(main)> market.vendors_that_sell(item1)
#=> [#<Vendor:0x00007fe1348a1160...>, #<Vendor:0x00007fe134910650...>]

pry(main)> market.vendors_that_sell(item4)
#=> [#<Vendor:0x00007fe1349bed40...>]

pry(main)> vendor1.potential_revenue
#=> 29.75

pry(main)> vendor2.potential_revenue
#=> 345.00

pry(main)> vendor3.potential_revenue
#=> 48.75  
```

## Iteration 3 - Items sold at the Market

```markdown
There are **3** Possible Method in Iteration 3:
1. Market #total_inventory
2. Market #overstocked_items
3. Market #sorted_item_list
```

Use TDD to update your `Market` class so that it responds to the following:

Add a method to your `Market` class called `sorted_item_list` that returns a list of names of all items the Vendors have in stock, sorted alphabetically. This list should not include any duplicate items.

Additionally, your `Market` class should have a method called `total_inventory` that reports the quantities of all items sold at the market. Specifically, it should return a hash with items as keys and hash as values - this sub-hash should have two key/value pairs: quantity pointing to total inventory for that item and vendors pointing to an array of the vendors that sell that item.

You `Market` will also be able to identify `overstocked_items`.  An item is overstocked if it is sold by more than 1 vendor AND the total quantity is greater than 50.


## Iteration 4 - Selling Items

```markdown
There are **2** Possible Methods in Iteration 4:
1. Market #date
2. Market #sell
```

Use TDD to update the `Market` class so that it responds to the following:

Add a method to your Market class called `sell` that takes an item and a quantity as arguments. There are two possible outcomes of the `sell` method:

1. If the Market does not have enough of the item in stock to satisfy the given quantity, this method should return `false`.

2. If the Market's has enough of the item in stock to satisfy the given quantity, this method should return `true`. Additionally, this method should reduce the stock of the Vendors. It should look through the Vendors in the order they were added and sell the item from the first Vendor with that item in stock. If that Vendor does not have enough stock to satisfy the given quantity, the Vendor's entire stock of that item will be depleted, and the remaining quantity will be sold from the next vendor with that item in stock. It will follow this pattern until the entire quantity requested has been sold.

For example, suppose vendor1 has 35 `peaches` and vendor3 has 65 `peaches`, and vendor1 was added to the market first. If the method `sell(<ItemXXX, @name = 'Peach'...>, 40)` is called, the method should return `true`, vendor1's new stock of `peaches` should be 0, and vendor3's new stock of `peaches` should be 60.
