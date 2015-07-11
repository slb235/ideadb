class Idea < ActiveRecord::Base
  attr_accessible :title, :project_id
  belongs_to :project
  belongs_to :user

  has_many :comments

  acts_as_taggable

  def as_json(options={})
    if options[:export]
      {
        title: title,
        user: user.id,
        tags: tags.map { |t| t.name },
        created_at: created_at,
        updated_at: updated_at
      }
    else
      super(:include => [:tags, :user, :comments])
    end
  end  
end
