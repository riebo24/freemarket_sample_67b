# README
## commentsテーブル
<!-- commentは１ー多の関係をuserと持っている -->
|Column|Type|Options|
|------|----|-------|
|text|string|null: false|
### Association
- belongs_to :users

## usersテーブル
<!-- userは多-多の関係をitemと持っている -->
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|username|string|null: false|
### Association
- has_many :comments
- has_many :items, through: :users_items

## users_itemsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## itemsテーブル
<!-- userは多-多の関係をitemと持っている -->
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|username|string|null: false|
### Association
- has_many :images
- has_many :users, through: :users_items
- has_many :categorys, through: :items_categorys
- belongs_to :bland

## items_categorysテーブル
|Column|Type|Options|
|------|----|-------|
|category|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|
### Association
- belongs_to :category
- belongs_to :item

## categorysテーブル
<!-- userは多-多の関係をitemと持っている -->
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|username|string|null: false|
### Association
- has_many :items, through: :items_categorys

## imagesテーブル
<!-- userは多-多の関係をitemと持っている -->
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|username|string|null: false|
### Association
- belongs_to :item

## blandsテーブル
<!-- userは多-多の関係をitemと持っている -->
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|username|string|null: false|
### Association
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
