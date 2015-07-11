class User < ActiveRecord::Base
  has_many :project_users
  has_many :projects, :through => :project_users
  has_many :ideas
  has_many :comments

  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, :presence => true, :length => { :maximum => 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence =>   true,
                    :format =>     { :with => VALID_EMAIL_REGEX },
                    :uniqueness => { :case_sensitive => false }
  validates :password, :presence => true, :length => { :minimum => 6 }
  validates :password_confirmation, :presence => true


  def as_json(options={})
    {
      email: email,
      name: name,
      id: id
    }
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.base64.tr("+/", "-_")
    end
end