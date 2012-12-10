class AddUserReferenceToIdea < ActiveRecord::Migration
  def change
    change_table :ideas do |t|
      t.references :user
    end
  end
end
