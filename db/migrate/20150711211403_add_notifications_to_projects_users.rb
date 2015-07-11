class AddNotificationsToProjectsUsers < ActiveRecord::Migration
  def change
    add_column :projects_users, :email_notify, :boolean, default: false
    add_column :projects_users, :sms_notify, :boolean, default: false
  end
end
