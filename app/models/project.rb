class Project < ActiveRecord::Base
  has_and_belongs_to_many :users

  attr_accessible :title

  validates :title, :presence => true, :length => { :maximum => 50 }
end
