class ProjectUser < ActiveRecord::Base
  set_table_name :projects_users

  belongs_to :user
  belongs_to :project

  attr_accessible :body_bg, :tag_bg, :tag_color, :link_color, :project, :user
end
