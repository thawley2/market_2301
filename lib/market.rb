require 'date'

class Market
  attr_reader :name, :vendors, :date

  def initialize(name)
    @name = name
    @vendors = []
    @date = Date.today
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.select do |vendor|
      vendor.inventory.keys.include?(item)
    end
  end

  def sorted_item_list
    @vendors.flat_map do |vendor|
      vendor.inventory.map do |item, _|
        item.name
      end
    end.uniq.sort
  end

  def total_inventory
    inventory = {}
    all_items.each do |item|
      inventory[item] = {
        quantity: total_quantity(item), 
        vendors: vendors_that_sell(item)
      }
    end
    inventory
  end

  def all_items
    @vendors.flat_map do |vendor|
      vendor.inventory.keys
    end.uniq
  end

  def total_quantity(item)
    @vendors.sum do |vendor|
      vendor.check_stock(item)
    end
  end

  def overstocked_items
    all_items.select do |item|
      vendors_that_sell(item).length >= 2 && total_quantity(item) >= 50
    end
  end

  def sell(item, amount)
  #sell that returns true
    #iterate over vendors and 'find' the first vendor that has the item && inventory[item] != 0
      #check 'if' stock < amount, then 'amount -= stock' and set vendor inventory hash '[item] = 0'
        #loop back through vendors
      #'if' stock > amount, then subtract amount from vendors inventory hash '[item] -= amount'
  #sell that returns false
    #total_quantity(item) < amount

    if total_quantity(item) < amount
      return false
    else
      vendor = @vendors.find do |vendor|
        vendor if vendor.inventory[item] != 0
      end
      if vendor.inventory[item] < amount
        amount -= vendor.inventory[item]
        vendor.inventory[item] = 0
        sell(item, amount)
      end
        vendor.inventory[item] -= amount
        return true
    end
  end
end
