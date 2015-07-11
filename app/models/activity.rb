class Activity < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :idea
  attr_accessible :action, :project, :user, :idea

  def as_json(options={})
    {
      idea: idea ? idea.id : 0,
      created_at: created_at,
      user: user ? user.id : 0,
      action: action,
      updated_at: updated_at
    }
  end
end
