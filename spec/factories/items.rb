FactoryBot.define do
  factory :item do

    name              {"商品名"}
    category_id       {"カテゴリー"}
    status            {"1000"}
    condition         {"商品の状態"}
    cost              {"配送方法"}
    delivery          {"配送元地域"}
    send_address      {"大阪"}
    send_date         {"発送までの日数"}
    price             {"300"}
  end
end
