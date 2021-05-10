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

  validates :name, presence: true
  validates :uid, presence: true
  validates :occupation_id, numericality: { other_than: 1 }
  validates :workplace_id, numericality: { other_than: 1 }
  validates :group, numericality: { other_than: 1 } 
  
end
