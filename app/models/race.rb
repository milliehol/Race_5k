class Race < ActiveRecord::Base
  belongs_to :user
  belongs_to :city
  validates_presence_of :user_id, :city_id, :name, :date, :time
end
