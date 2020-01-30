# README
## commentsテーブル
<!-- commentは１ー多の関係をuserと持っている -->
<!-- commentは一対多の関係をitemsと持っている -->
|Column|Type|Options|
|------|----|-------|
|text|string|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## usersテーブル
<!-- userは多-多の関係をitemと持っている -->
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false,limit:15|
|emall|string|null: false|
|password|string|null: false|
|first_name|string|null: false,limit:30|
|last_name|string|null: false,limit:30|
|first_kane|string|null: false,limit:30|
|last_kane|string|null: false,limit:30|
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
|status|string|null: false|
|cost|interger|null: false|
|delivery|interger|null: false|
|category_id|references|null: false, foreign_key: true|
|size_id|references|null: false, foreign_key: true|
|brand_id|references|foreign_key: true|
|deal|boolean|null: false|
### Association
- belongs_to :category
- belongs_to :size
- belongs_to :brand
- belongs_to :user
- has_many :images 
- has_many :comments


## categorysテーブル
<!-- userは多-多の関係をitemと持っている -->
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|


### Association
- has_many :items
- has_many :sizes, through: :categorys_sizes


## imagesテーブル
<!-- userは多-多の関係をitemと持っている -->
|Column|Type|Options|
|------|----|-------|
|image_name|string|null: false|
|item_id|reference|null: false, foreign_key: true|

### Association
- belongs_to :item

## brandsテーブル
<!-- userは多-多の関係をitemと持っている -->
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items


## sizesテーブル
|colunu|Type|options|
|------|----|-------|
|size|string|null: false|

### Asociation
- has_many :items
- has_many :categorys, through: :categorys_sizes

## categorys_sizesテーブル
|colunu|Type|options|
|------|----|-------|
|category_id|references|null: false, foreign_key: true|
|size_id|references|null: false, foreign_key: true|

### Asociation
- belongs_to :size
- belongs_to :category



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
