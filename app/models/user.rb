class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :encrypted_password, format:{with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{7,}/}

  with_options presence: true do
    validates :nickname
    validates :last_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "last_name Full-width characters"}
    validates :first_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "first_name Full-width characters"}
    validates :kana_last, format: {with: /\A[ァ-ヶー－]+\z/, message: "kana_last Full-width katakana characters"}
    validates :kana_first, format: {with: /\A[ァ-ヶー－]+\z/, message: "kana_first Full-width katakana characters"}
    validates :birthday
  end

end
