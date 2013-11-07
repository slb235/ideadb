class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :project
      t.references :user
      t.references :idea
      t.string :action

      t.timestamps
    end
    add_index :activities, :project_id
    add_index :activities, :user_id
    add_index :activities, :idea_id
  end
end
