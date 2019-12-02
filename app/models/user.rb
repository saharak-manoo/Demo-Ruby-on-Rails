class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable, :validatable
  validates :email, presence: true, allow_blank: false, uniqueness: true
  validates :password, presence: true, allow_blank: false, confirmation: true, if: :can_validate_password?
  validates_confirmation_of :password
  after_create :send_confirmation_instructions

  def can_validate_password?
    new_record? || changing_password
  end
end
