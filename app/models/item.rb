class Item < ApplicationRecord
  belongs_to :buyer_id
  belongs_to :seller_id
  belongs_to :category_id
  belongs_to :size_id
  belongs_to :brand_id
  
  validates :deal, inclusion: { in: [true, false] }
end
