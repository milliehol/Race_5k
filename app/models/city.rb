class City < ActiveRecord::Base
  has_many :races
  has_many :users, through: :races
  validates_presence_of :name, :state

  def slug
    self.name.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    self.all.detect{|item| item.slug == slug}
  end
end
