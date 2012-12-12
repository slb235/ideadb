class Idea < ActiveRecord::Base
  attr_accessible :title, :project_id
  belongs_to :project
  belongs_to :user

  has_many :comments

  acts_as_taggable

  def as_json(options={})
    super(:include => [:tags, :user])
  end  
end
