class AddStyleInfoToProjectsUsers < ActiveRecord::Migration
  def change
    add_column :projects_users, :body_bg, :string
    add_column :projects_users, :tag_bg, :string
    add_column :projects_users, :tag_color, :string
    add_column :projects_users, :link_color, :string   
  end
end
