class User < ActiveRecord::Base

  has_many :locations
  has_many :notifications, dependent: :destroy
  attr_accessor :remember_token
	before_save   { self.email= email.downcase } 
  	validates :name,  presence: true, length: { maximum: 50 }
  	validates :gender,presence: true
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :phone, presence: true,  length: {minimum: 11,maximum: 11},
                      uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    # Returns the hash digest of the given string.
  	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end
    ###############################################################################################
    #if the user choose to be remembered
      
    def remember_database
      self.remember_token = SecureRandom.urlsafe_base64
      update_attribute(:remember_digest, User.digest(remember_token))
    end
    #the remember_token match the one in the data base or not
    def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
    #forget the user to logout
    def forget
      update_attribute(:remember_digest, nil)
    end
    
end
