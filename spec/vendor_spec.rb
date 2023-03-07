require 'spec_helper'

RSpec.describe Vendor do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")

    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  describe '#initialize' do
    it 'exists' do
      expect(@vendor).to be_a(Vendor)
    end

    it 'has a name' do
      expect(@vendor.name).to eq('Rocky Mountain Fresh')
    end

    it 'starts with an empty hash for inventory' do
      expect(@vendor.inventory).to eq({})
    end
  end

  describe '#check_stock' do
    it 'can return 0 if that item is not stocked' do
      expect(@vendor.check_stock(@item1)).to eq(0)
    end
  end

  describe '#stock' do
    it 'can add an item and amount to inventory' do
      @vendor.stock(@item1, 30)

      expect(@vendory.inventory).to eq({@item1 => 30})
    end
  end
end