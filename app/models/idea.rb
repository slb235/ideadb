class Idea < ActiveRecord::Base
  attr_accessible :title, :project_id
  belongs_to :project

  acts_as_taggable

  def as_json(options={})
    super(:include => :tags)
  end  
end
