class AddIdeaProjectRelation < ActiveRecord::Migration
  def change
    change_table :ideas do |t|
      t.references :project
    end
  end
end
