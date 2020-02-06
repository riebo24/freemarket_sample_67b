class Item < ApplicationRecord
  belongs_to :buyer
  belongs_to :seller
  belongs_to :category
  belongs_to :size
  belongs_to :brand
  has_many :images 

  validates :deal, inclusion: { in: [true, false] }

  hhh
end


