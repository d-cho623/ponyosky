class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :approvals, dependent: :destroy
  has_many :approved_items, through: :approvals, source: :item
  has_many :rejects, dependent: :destroy
  has_many :rejected_items, through: :rejects, source: :item
  has_many :comments, dependent: :destroy

  def already_approved?(item)
    self.approvals.exists?(item_id: item.id)
  end

  def already_rejected?(item)
    self.rejects.exists?(item_id: item.id)
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :occupation
  belongs_to :group
  belongs_to :workplace

  validates :name, presence: true, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'はスペースを空けず、全角(漢字、ひらがな、カタカナ)のみで入力してください'}
  validates :uid, uniqueness: { case_sensitive: true }, presence: true, format: {with: /\A[a-zA-Z0-9_\-.]{3,15}\z/, message: "は3〜15文字の半角英数字で入力してください"}
  validates :occupation_id, numericality: { other_than: 1, message: 'が選択されていません' }

  
end
