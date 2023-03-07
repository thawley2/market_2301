class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
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
    inventory = Hash.new(0)
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
end
