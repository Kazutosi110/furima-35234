# テーブル設計

## users テーブル

| Column         | Type     | Options     |
| --------       | ------   | ----------- |
| nickname       | string   | null: false |
| email          | string   | null: false |
| password       | string   | null: false |
| last_name      | string   | null: false |
| first_name     | string   | null: false |
| kana_last      | string   | null: false |
| kana_first     | string   | null: false |
| birthday       | datetime | null: false |

### Association

- has_many :items
- has_many :purchases
- has_many :purchases_record

## items テーブル

| Column            | Type       | Options                        |
| ------            | ---------- | ------------------------------ |
| items_name        | string     | null: false                    |
| items_information | text       | null: false                    |
| category          | integer    | null: false                    |
| items_condition   | integer    | null: false                    |
| delivery_charge   | integer    | null: false                    |
| shipping_area     | integer    | null: false                    |
| shipping_date     | integer    | null: false                    |
| price             | integer    | null: false                    |
| fee               | integer    | null: false                    |
| profit            | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase
- has_one :purchase_record

## purchases テーブル

| Column                | Type       | Options                        |
| ------                | ---------- | ------------------------------ |
| delivery_postcode     | string     | null: false                    |
| delivery_prefecture   | string     | null: false                    |
| delivery_municipality | string     | null: false                    |
| delivery_address      | string     | null: false                    |
| delivery_building     | string     |                                |
| delivery_phone        | integer    | null: false                    |
| user                  | references | null: false, foreign_key: true |
| item                  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## purchase_record テーブル

| Column                | Type       | Options                        |
| ------                | ---------- | ------------------------------ |
| user                  | references | null: false, foreign_key: true |
| item                  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item