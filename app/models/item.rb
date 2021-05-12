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

  validates :number, presence: true, if: -> { code.blank? }
  validates :code, presence: true, if: -> { number.blank? }

end
