class User < ApplicationRecord
  validates :name, presence: true,
                   length: { maximum: 50 }
  validates :nickname, presence: true,
                       uniqueness: true,
                       length: { maximum: 30 },
                       format: { without: /\s/, message: "doesn't allow spaces" }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
