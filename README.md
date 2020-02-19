# freemarket_sample_67b
- フリマアプリ「メルカリ」のクローンサイト。
- ER図 
- https://gyazo.com/03c1121bcc4b524cda192e6d3ef40dff
- 本番環境にデプロイ
- 商品出品ページの実装
- 商品出品機能
- 商品詳細表示
- 商品情報編集
- 商品削除
- 商品詳細ページ
- 商品情報編集
- 商品削除
- ユーザーマイページ
- ユーザー新規登録、ログイン(メールアドレスのみ)
- カテゴリ機能
- 商品購入確認ページ
- 商品一覧表示
- 商品詳細ページ
- 商品購入機能
- ユーザー新規登録/ログインページ
- トップページ



## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|string|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false,limit:10|
|emall|string|null: false|
|password|string|null: false|
|first_name|string|null: false,limit:10|
|last_name|string|null: false,limit:10|
|first_kane|string|null: false,limit:10|
|last_kane|string|null: false,limit:10|
|post_number|interger|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string||
|phone_number|string||
|birthday|date|null: false|
|card|date|null: false|
|profile|string|null: false|
### Association
- has_many :comments
- has_many :items

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|buyer_id|references|foreign_key: true|
|seller_id|references|null: false, foreign_key: true|
|name|string|null: false|
|price|integer|null: false|
|status|text|null: false|
|cost|string|null: false|
|delivery|string|null: false|
|category_id|references|null: false, foreign_key: true|
|brand|string||
|deal|boolean||
|send_address|string|null: false|
|send_date|string|null: false|
|condition|string|null: false|
### Association
- belongs_to :category
- belongs_to :size
- belongs_to :brand
- belongs_to :user
- has_many :images
- has_many :comments

## categorysテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :items
- has_many :sizes, through: :categorys_sizes

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image_name|string|null: false|
|item_id|reference|null: false, foreign_key: true|

### Association
- belongs_to :item

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items

## cardsテーブル
|column|Type|Options|
|------|----|-------|
|card_id|string|null: false|
|customer_id｜string|null: false|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
