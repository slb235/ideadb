class Idea < ActiveRecord::Base
  attr_accessible :title, :project_id
  belongs_to :project
  belongs_to :user

  has_many :comments

  acts_as_taggable

  def as_json(options={})
    if options[:web]
      super(:include => [:tags, :user, :comments])
    else
      {
        title: title,
        user: user ? user.id : 0,
        tags: tags.map { |t| t.name },
        created_at: created_at,
        updated_at: updated_at
      }     
    end
  end  
end
