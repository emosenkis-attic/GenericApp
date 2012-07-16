class Listing < ActiveRecord::Base
  attr_accessible :approved, :descr, :title, :url, :user_id
  belongs_to :user
end
