# README
## commentsテーブル
<!-- commentは１ー多の関係をuserと持っている -->
<!-- commentは一対多の関係をitemsと持っている -->
|Column|Type|Options|
|------|----|-------|
|text|string|null: false|
|user|string|null: false|
|item|string|null: false|
### Association
- belongs_to :users
- belongs_to :items

## usersテーブル
<!-- userは多-多の関係をitemと持っている -->
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false,limit:15|
|first_name|string|null: false,limit:30|
|last_name|string|null: false,limit:30|
|first_kane|string|null: false,limit:30|
|last_kane|string|null: false,limit:30|
|name_to_send|string||
|kananame_to_send|string||
|post_number|interger||
|city|string||
|house_number|string||
|building_name|string||
|phone_number|string||
|birthday|date|null: false|
|card|date|null: false|
|profile|string|null: false|

### Association
- has_many :comments
- belong_to :items
- belong_to :receipt

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false|
|item|references|null: false|
|price|integer|null: false|
|description|string|null: false|
|status|string|null: false|
|from|string|null: false|
|cost|interger|null: false|
|delivery|interger|null: false|
|category|string|null: false|

### Association
- belongs_to :category
- belongs_to :size
- belongs_to :brand
- has_many :receipts
- has_many :images
- has_many :sales 

## categorysテーブル
<!-- userは多-多の関係をitemと持っている -->
|Column|Type|Options|
|------|----|-------|
|category_name|string|null: false|
### Association
- belongs_to :items

## imagesテーブル
<!-- userは多-多の関係をitemと持っている -->
|Column|Type|Options|
|------|----|-------|
|image_name|string|null: false|
### Association
- belongs_to :items

## brandsテーブル
<!-- userは多-多の関係をitemと持っている -->
|Column|Type|Options|
|------|----|-------|
|username|string|null: false|
### Association
- has_many :item

## receiptテーブル
|colunu|Type|options|
|------|----|-------|
|receipt|integer|null: false|
|seller|string|null: false|
|buyer|string|null: false|
|deals|integer|null: false|
### Association
- has_many :user
- has_one :items

## sizesテーブル
|colunu|Type|options|
|------|----|-------|
|size|string|null: false|

### Asociation
- has_many :items

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
