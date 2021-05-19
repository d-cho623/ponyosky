class Item < ApplicationRecord
  belongs_to :user
  has_many :approvals, dependent: :destroy
  has_many :approved_users, through: :approvals, source: :user
  has_many :rejects, dependent: :destroy
  has_many :rejected_users, through: :rejects, source: :user
  has_many :comments, dependent: :destroy
  # has_one_attached :image

  with_options presence: true do
    validates :maker
    validates :name
    validates :number_or_code
    validates :trading_company_or_retrieval
  end

  with_options presence: true, numericality: { only_integer: true } do
    validates :quantity
    validates :price
    validates :total_price
  end

  # validates :image, presence: { message: 'を添付してください' }
  
  private
  def number_or_code
    number.presence or code.presence
  end

  def trading_company_or_retrieval
    trading_company.presence or retrieval.presence
  end
  
end
