class Idea < ActiveRecord::Base
  attr_accessible :title, :project_id
  belongs_to :project
end
