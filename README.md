# テーブル設計

## users テーブル

| Column         | Type    | Options     |
| --------       | ------  | ----------- |
| nickname       | string  | null: false |
| email          | string  | null: false |
| password       | string  | null: false |
| last_name      | string  | null: false |
| first_name     | string  | null: false |
| kana_last      | string  | null: false |
| kana_first     | string  | null: false |
| birthday_year  | integer | null: false |
| birthday_month | integer | null: false |
| birthday_day   | integer | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column            | Type       | Options                        |
| ------            | ---------- | ------------------------------ |
| items_name        | string     | null: false                    |
| items_information | text       | null: false                    |
| category          | string     | null: false                    |
| items_condition   | string     | null: false                    |
| delivery_charge   | string     | null: false                    |
| shipping_area     | string     | null: false                    |
| shipping_date     | string     | null: false                    |
| price             | integer    | null: false                    |
| fee               | integer    | null: false                    |
| profit            | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column                | Type       | Options                        |
| ------                | ---------- | ------------------------------ |
| card_number           | integer    | null: false                    |
| card_day              | integer    | null: false                    |
| card_year             | integer    | null: false                    |
| card_code             | integer    | null: false                    |
| delivery_postcode     | integer    | null: false                    |
| delivery_prefecture   | string     | null: false                    |
| delivery_municipality | string     | null: false                    |
| delivery_address      | string     | null: false                    |
| delivery_building     | string     |                                |
| delivery_phone        |  integer   | null: false                    |
| user                  | references | null: false, foreign_key: true |
| item                  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item