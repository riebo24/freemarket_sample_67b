require 'rails_helper'

describe Image do
  describe '#create' do

  it "is valid with an item_id, image_name" do
    image = build(:image)
    expect(image).to be_valid

  end

  it "is invalid without an item_id" do
    image = build(:image, item_id: nil)
    image.valid?
    expect(image.errors[:item_id]).to include()
  end

  it "is invalid without an image_name" do
    image = build(:image, image_name: "")
    image.valid?
    expect(image.errors[:image_name]).to include()
  end

  end
end


