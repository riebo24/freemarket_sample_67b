class Item < ApplicationRecord
  belongs_to :buyer, optional: true
  belongs_to :seller, optional: true
  belongs_to :user, optional: true
  belongs_to :category, optional: true
  has_many   :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :deal, default: false,inclusion: { in: [true, false] }
  validates :name, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :cost, presence: true
  validates :delivery, presence: true
  validates :category_id, presence: true
  validates :send_address, presence: true
  validates :send_date, presence: true
  validates :condition, presence: true

end


