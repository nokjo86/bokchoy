class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile, dependent: :destroy
  after_create :init_profile

  def init_profile
    profile = Profile.new(user_id: self.id)
    profile.save(validate: false)
  end

end
