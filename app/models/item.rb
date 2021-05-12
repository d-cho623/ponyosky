class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :pdf

  with_options presence: true do
    validates :maker
    validates :name
    validates :unit
  end

  with_options presence: true, numericality: { only_integer: true } do
    validates :quantity
    validates :price
    validates :total_price
  end

 # codeが空ならば、numberを必須にする
 validates :number, presence: true, unless: :code?

 # numberが空ならば、codeを必須にする
 validates :code, presence: true, unless: :number?


end
