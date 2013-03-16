class IdeaToText < ActiveRecord::Migration
  def up
    change_table :ideas do |t|
      t.change :title, :text, :limit => nil
    end
  end

  def down
    change_table :ideas do |t|
      t.change :title, :string
    end    
  end
end
