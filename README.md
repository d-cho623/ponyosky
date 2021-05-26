# App name
PONYOSKY

# Description
社内での購入申請アプリ。  
①ユーザー(誰でも)は備品の購入申請をすることができる。  
②ユーザー(課長)は購入申請を承認及び却下することができる。  
③購入申請が承認された場合は、ユーザー(工具室)が発注処理をすることができる。  
④ユーザー(工具室)が発注処理をした申請は納入待ちとなる。  
⑤ユーザー(受入グループ)は納入待ちの申請が納入されると、納入処理をできる。  
以上の流れで申請が進んでいくが、それぞれ現状どの状況にあるか、確認できるようになっている。  

# App URL
http://35.73.229.91/

# 制作背景(意図)
前職で、工場側の人と話をした時に商品の購入処理が面倒という話を聞いたことがあった。  
具体的には、申請書を作成して課長に持っていき承認をもらったら、工具室に発注申請をする。  
工具室は発注をするが、申請した本人は本当に発注されているのか？まだ発注されていないのか？  
状況が全くわからないそうであった。  
そのため、それらが一つのアプリケーションで管理できたら非常に便利だと思い、今回のPONYOSKYを作成した。  

# DEMO

# 工夫したポイント


# 使用技術

# 課題や今後実装したい機能
よく発注する商品は、リストから発注できるようにしたい。  
納入処理された商品は、それ用のページを作り、一覧として見れるようにしたい。  


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
- has_many: approvals
- has_many: rejects

## items テーブル

| Column                  | Type       | Options                        |
| ----------------------  | ------     | ----------------------------   |
| maker                   | string     | null: false                    |
| name                    | string     | null: false                    |
| number                  | integer    | null: false                    |
| code                    | integer    | null: false                    |
| quantity                | integer    | null: false                    |
| price                   | integer    | null: false                    |
| total_price             | integer    | null: false                    |
| trading_company         | string     | null: false                    |
| retrieval               | string     | null: false                    |
| user                    | references | null: false, foreign_key: true |

### Association
- belongs_to: user
- has_many: approvals
- has_many: rejects


## approvals テーブル

| Column                  | Type           | Options                        |
| ----------------------  | -------------- | ----------------------------   |
| user                    | references     | null: false,foreign_key: true  |
| item                    | references     | null: false,foreign_key: true  |

### Association
- belongs_to: user
- belongs_to: item


## rejects テーブル

| Column                  | Type           | Options                        |
| ----------------------  | -------------- | ----------------------------   |
| user                    | references     | null: false,foreign_key: true  |
| item                    | references     | null: false,foreign_key: true  |

### Association
- belongs_to: user
- belongs_to: item


## comments テーブル

| Column                  | Type           | Options                        |
| ----------------------  | -------------- | ----------------------------   |
| text                    | text           | null: false                    |
| user                    | references     | null: false,foreign_key: true  |
| item                    | references     | null: false,foreign_key: true  |
