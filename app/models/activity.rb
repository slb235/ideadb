class Activity < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :idea
  attr_accessible :action, :project, :user, :idea

  def as_json(options={})
    {
      idea: idea.id,
      created_at: created_at,
      user: user,
      action: action,
      updated_at: updated_at
    }
  end
end
