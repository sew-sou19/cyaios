class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # バリデーション 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email = email.downcase }
  validates :email,     {presence: true, format: { with: VALID_EMAIL_REGEX }}
  validates :password,  {length: { in: 8..32 }, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]/}}

  # Confirmメール有効期限のチェック
  def is_confirmation_period_expired?
    self.confirmation_period_expired?
  end

  def get_user_name
    mail = self.email
    index = mail.index("@") - 1
    user_name = mail.slice(0..index)
  end
end
