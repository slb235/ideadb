class Activity < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :idea
  attr_accessible :action, :project, :user, :idea
end
