class User < ApplicationRecord
  before_save {self.email.downcase!}
  has_many :microposts

  validates :name, presence: true, length: {maximum: 20}
  validates :email, presence: true,
            format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
            uniqueness: {case_sencitive: false}
  validates :password_digest, presence: true

  has_secure_password
end
