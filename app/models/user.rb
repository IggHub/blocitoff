class User < ActiveRecord::Base

  attr_accessor :login

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :username,
            :presence => true,
            :uniqueness => {
              :case_sensitive => false
            }
  has_many :items


  def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup
     if login = conditions.delete(:login)
       where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
     elsif conditions.has_key?(:username) || conditions.has_key?(:email)
       where(conditions.to_h).first
     end
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
