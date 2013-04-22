class ActsAsFollowableMigration < ActiveRecord::Migration
  def change
    create_table :following_items do |t|
      t.references :follower, :null => false
      t.references :followee, :null => false

      t.timestamps
    end
    add_index :following_items, :follower_id
    add_index :following_items, :followee_id
    add_index :following_items, [:follower_id, :followee_id], unique: true
  end
end
