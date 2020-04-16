class User < ActiveRecord::Base
  has_many :races
  has_many :cities, through: :races
  has_secure_password
  validates_presence_of :username, :email
  validates :email, :username, uniqueness: true
  #validate :is_email_available?, :is_username_available?

  def slug
    self.username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    self.all.detect{|item| item.slug == slug}
  end

  protected

    def is_email_available?
      errors.add(:email, "The email #{email} has already been taken.") if User.find_by(email: email)
    end

    def is_username_available?
        errors.add(:username, "The username #{username} has already been taken.") if User.find_by(username: username)
    end


end
