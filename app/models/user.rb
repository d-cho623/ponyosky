class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :occupation
  belongs_to :group
  belongs_to :workplace

  validates :name, presence: true, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'はスペースを空けず、全角(漢字、ひらがな、カタカナ)のみで入力してください'}
  validates :uid, uniqueness: true, presence: true, format: {with: /\A[a-zA-Z0-9]+\z/}
  validates :occupation_id, numericality: { other_than: 1, message: 'が選択されていません' }
  # validates :workplace_id, numericality: { other_than: 1 }
  # validates :group_id, numericality: { other_than: 1 } 
  
end
