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

  def as_json(options={})
    {
      title: title,
      users: users,
      activities: activities,
      ideas: ideas.map { |i| { title: i.title, user: i.user ? i.user.id : 0, tags: i.tags.map { |t| t.name }, comments: i.comments.map { |c| { id: c.id, content: c.content, user: c.user ? c.user.id : 0, updated_at: c.updated_at, created_at: c.created_at } }, created_at: i.created_at, updated_at: i.updated_at } }
    }
  end
end

