class User < ActiveRecord::Base
  has_many :races
  has_many :cities, through: :races
  has_secure_password
  validates_presence_of :username, :email
  validates :email, :username, uniqueness: true
 

  def slug
    self.username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    self.all.detect{|item| item.slug == slug}
  end


end
