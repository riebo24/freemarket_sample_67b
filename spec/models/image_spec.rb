require 'rails_helper'

describe Image do
  describe '#create' do

  it "is valid with a image_name, item_id" do
    image = build(:image)
    
    expect(image).to be_valid
  end

  it "is invalid without an image_name" do
    image = build(:image, image_name: "")
    image.valid?
    expect(image.errors[:image_name]).to include("を入力してください")
  end

  
  end
end


