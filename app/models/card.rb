class Card < ApplicationRecord
  validates :customer_id, presence: true
  validates :card_id, presence:true

  # customer_id,card_idは、_idがついているものの、外部キーではない
end
