class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  WARDS = ["Quận 1","Quận 2","Quận 3","Quận 5","Quận 6","Quận 9","Quận 10","Quận Tân Bình"]

  # has_secure_password
  has_one_attached :avatar

  # validates :name, :username, presence: true
  # validates :username, :email, uniqueness: true
  # validates :password, presence: true, length: { minimum: 6 }, on: :create

  enum gender: %i(male female other)
  enum address: WARDS
  # enum address: [ :active, :archived ]

  scope :by_age, ->(age) { where(age: age) if age.present? }
  scope :by_address, ->(address) { where(address: address) if address.present? }
  scope :by_gender, ->(gender) { where(gender: gender) if gender.present? }

  def self.all_except_id(user_id)
    self.where.not(id: user_id)
  end

  def self.filter(user_id, age, address, gender)
    where.not(id: user_id).by_age(age).by_address(address).by_gender(gender)
  end

 
end
