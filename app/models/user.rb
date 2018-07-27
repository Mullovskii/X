class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [ :swimming_pool_baby, :swimming_coach, :versed_surfer, :god ]

  has_many :picks, as: :author, dependent: :destroy
  has_one :shop, as: :owner
  has_one :showroom, as: :owner
  after_create :generate_showroom

  def generate_showroom
  	Showroom.create(owner_id: self.id, owner_type: self.class.to_s)
  end

end
