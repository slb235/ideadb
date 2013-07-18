class Project < ActiveRecord::Base
  has_many :project_users
  has_many :users, :through => :project_users
  has_many :ideas

  attr_accessible :title

  validates :title, :presence => true, :length => { :maximum => 50 }
end
