class Comment < ActiveRecord::Base
  attr_accessible :content, :idea, :user

  belongs_to :user
  belongs_to :idea

  def as_json(options={})
    super(:include => :user)
  end   
end
