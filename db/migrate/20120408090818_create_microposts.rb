class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user
      t.references :group

      t.timestamps
    end
    add_index :microposts, :user_id
    add_index :microposts, :group_id
  end
end
