class Project < ActiveRecord::Base
  has_many :project_users
  has_many :users, :through => :project_users
  has_many :ideas
  has_many :activities

  attr_accessible :title

  validates :title, :presence => true, :length => { :maximum => 50 }


  def last_activity
    activities.last
  end
end
