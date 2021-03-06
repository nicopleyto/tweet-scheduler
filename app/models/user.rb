class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :twitter_accounts, dependent: :destroy
  has_many :tweets

  after_create :set_initial_time_zone

  #converts client side timezone to rails timezone upon creation of user. limited to scope of rake:time:zones:all
  def set_initial_time_zone 
    if self.time_zone?
      js_timezone = self.time_zone
      self.update(time_zone: ActiveSupport::TimeZone::MAPPING.key(js_timezone))
    end
  end

end
