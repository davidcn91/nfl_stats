class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  validates_confirmation_of :password
  validates :first_name, :last_name, :email, :team_id, presence: true
  validates :email, uniqueness: true

  belongs_to :team
  has_many :games

  def admin?
    role == "admin"
  end
end
