require 'rails_helper'
describe Item do
  describe '#create' do


    it "is valid with a name, category_id, condition, cost, delivery, send_addres, send_date, price" do
      item = build(:item)
      expect(item).to be_valid
    end
      
    it "is invalid without a name" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "is invalid without an category_id" do
      item = build(:item, category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end

    it "is invalid without a condition" do
      item = build(:item, condition: nil)
      item.valid?
      expect(item.errors[:condition]).to include("を入力してください")
    end

    it "is invalid without a cost" do
      item = build(:item, cost: nil)
      item.valid?
      expect(item.errors[:cost]).to include("を入力してください")
    end

    it "is invalid without a delivery" do
      item = build(:item, delivery: nil)
      item.valid?
      expect(item.errors[:delivery]).to include("を入力してください")
    end

    it "is invalid without a send_address" do
      item = build(:item, send_address: nil)
      item.valid?
      expect(item.errors[:send_address]).to include("を入力してください")
    end

    it "is invalid without a send_date" do
      item = build(:item, send_date: nil)
      item.valid?
      expect(item.errors[:send_date]).to include("を入力してください")
    end

    it "is invalid without a price" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
      
    end
  end
end