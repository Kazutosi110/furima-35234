# テーブル設計

## users テーブル

| Column              | Type     | Options                   |
| --------            | ------   | -----------               |
| nickname            | string   | null: false               |
| email               | string   | null: false, unique: true |
| encrypted_password  | string   | null: false               |
| last_name           | string   | null: false               |
| first_name          | string   | null: false               |
| kana_last           | string   | null: false               |
| kana_first          | string   | null: false               |
| birthday            | date     | null: false               |

### Association

- has_many :items
- has_many :purchases_records

## items テーブル

| Column               | Type       | Options                        |
| ------               | ---------- | ------------------------------ |
| items_name           | string     | null: false                    |
| items_information    | text       | null: false                    |
| category_id          | integer    | null: false                    |
| items_condition_id   | integer    | null: false                    |
| delivery_charge_id   | integer    | null: false                    |
| shipping_area_id     | integer    | null: false                    |
| shipping_date_id     | integer    | null: false                    |
| price                | integer    | null: false                    |
| user                 | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_record

## purchases テーブル

| Column                  | Type       | Options                        |
| ------                  | ---------- | ------------------------------ |
| delivery_postcode       | string     | null: false                    |
| delivery_prefecture_id  | integer    | null: false                    |
| delivery_municipality   | string     | null: false                    |
| delivery_address        | string     | null: false                    |
| delivery_building       | string     |                                |
| delivery_phone          | integer    | null: false                    |
| purchase_record         | references | null: false, foreign_key: true |

### Association

belongs_to : purchase_record

## purchase_records テーブル

| Column                | Type       | Options                        |
| ------                | ---------- | ------------------------------ |
| user                  | references | null: false, foreign_key: true |
| item                  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :purchase