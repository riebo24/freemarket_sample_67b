require 'rails_helper'

describe item do
  describe '#create' do
    it "is valid with a name, price, status, cost, delivery, size_id, brand_id, deal, condition, comments" do
      item = build(:item)
      expect(item).to be_valid
    end

    it "is invalid without a name" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a price" do
      item = build(:item, email: nil)
      item.valid?
      expect(item.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a status" do
      item = build(:item, status: nil)
      item.valid?
      expect(item.errors[:status]).to include("can't be blank")
    end

    it "is invalid without a cost although with a password" do
      item = build(:item, cost: nil)
      item.valid?
      expect(item.errors[:cost]).to include("can't be blank")
    end

    it "is invalid without a delivery although with a password" do
      item = build(:item, cost: nil)
      item.valid?
      expect(item.errors[:cost]).to include("can't be blank")
    end

    it "is invalid with a nickname that has more than 7 characters " do
      item = build(:user, nickname: "aaaaaaaa")
      item.valid?
      expect(item.errors[:nickname][0]).to include("is too long")
    end

    it "is valid with a nickname that has less than 6 characters " do
      item = build(:user, nickname: "aaaaaa")
      expect(item).to be_valid
    end

    it "is invalid with a password that has less than 5 characters " do
      item = build(:item, password: "00000", password_confirmation: "00000")
      item.valid?
      expect(item.errors[:password][0]).to include("is too short")
    end
  end

end