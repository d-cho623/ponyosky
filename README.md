# テーブル設計

## users テーブル

| Column               | Type   | Options                   |
| ---------------      | ------ | ------------------------  |
| name                 | string | null: false               |
| email                | string | null: false, unique: true |
| encrypted_password   | string | null: false               |
| occupation_id        | integer| null: false               |
| uid                  | string | null: false               |
| workplace_id         | integer| null: false               |
| group_id             | integer| null: false               |

### Association
- has_many: items


| Column                  | Type       | Options                        |
| ----------------------  | ------     | ----------------------------   |
| applicant               | string     | null: false                    |
| maker                   | text       | null: false                    |
| name                    | integer    | null: false                    |
| number                  | integer    | null: false                    |
| code                    | integer    | null: false                    |
| quantity                | integer    | null: false                    |
| unit                    | string     | null: false                    |
| price                   | integer    | null: false                    |
| total_price             | integer    | null: false                    |
| trading_company         | string     | null: false                    |
| search                  | string     | null: false                    |
| user                    | references | null: false, foreign_key: true |

### Association
- belongs_to: user