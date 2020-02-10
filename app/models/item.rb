class Item < ApplicationRecord
  belongs_to :buyer, optional: true
  belongs_to :seller, optional: true
  belongs_to :user, optional: true
  belongs_to :category, optional: true
  belongs_to :size, optional: true
  belongs_to :brand, optional: true
  has_many   :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

   validates :deal, default: false,inclusion: { in: [true, false] }


end


