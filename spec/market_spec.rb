require 'spec_helper'

RSpec.describe Market do
  before(:each) do
    @market = Market.new("South Pearl Street Farmers Market")

    @vendor1 = Vendor.new('Rocky Mountain Fresh')
    @vendor2 = Vendor.new('Ba-Nom-a-Nom')
    @vendor3 = Vendor.new('Palisade Peach Shack')

    @item1 = Item.new({name: 'Peach', price: '$0.75'})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: 'Peach-Raspberry Nice Cream', price: '$5.30'})
    @item4 = Item.new({name: 'Banana Nice Cream', price: '$4.25'})
    @item5 = Item.new({name: 'Tacos', price: '$0.99'})

    @vendor1.stock(@item1, 35) 
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@market).to be_a(Market)
    end

    it 'has a name' do
      expect(@market.name).to eq('South Pearl Street Farmers Market')
    end

    it 'starts with an empty array of vendors' do
      expect(@market.vendors).to eq([])
    end

    it 'has a creation date' do
      expect(@market.date).to be_a(Date)
    end
  end

  describe '#add_vendor' do
    it 'can add a vendor to the vendors list' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end
  end

  describe '#vendor_names' do
    it 'can return an array of the vendor names' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe '#vendors_that_sell' do
    it 'can return a list of vendor objects that sell an item' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
      expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
      expect(@market.vendors_that_sell(@item5)).to eq([])
    end
  end

  describe '#sorted_item_list' do
    it 'can return a unique list of all items sorted alphabetically' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.sorted_item_list).to eq(['Banana Nice Cream', 'Peach', 'Peach-Raspberry Nice Cream', 'Tomato'])
    end
  end

  describe '#total_inventory' do
    before(:each) do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
    end

    it 'can create a uniq array of all item object' do
      expect(@market.all_items).to eq([@item1, @item2, @item4, @item3])
    end

    it 'can return a total quantity of an item from all vendors' do
      expect(@market.total_quantity(@item1)).to eq(100)
    end

    it 'can return a list of all items sold with how many are in stock and which vendors sell them' do
      expect(@market.total_inventory).to eq(
      {
        @item1 => {quantity: 100, vendors: [@vendor1, @vendor3]},
        @item2 => {quantity: 7, vendors: [@vendor1]},
        @item3 => {quantity: 25, vendors: [@vendor2]},
        @item4 => {quantity: 50, vendors: [@vendor2]}
      }
    )
    end
  end

  describe '#overstocked_items' do
    it 'can return a list of item objects that are overstocked' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.overstocked_items).to eq([@item1])
    end
  end

  describe '#sell' do
    it 'can sell inventory' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.sell(@item1, 30)).to be true
      expect(@vendor1.check_stock(@item1)).to eq(5)
    end
  end
end