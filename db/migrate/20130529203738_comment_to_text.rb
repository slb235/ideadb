class CommentToText < ActiveRecord::Migration
  def up
    change_table :comments do |t|
      t.change :content, :text, :limit => nil
    end
  end

  def down
    change_table :comments do |t|
      t.change :content, :string
    end    
  end
end
