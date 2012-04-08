class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text :content, :null => false
      t.references :user
      t.references :group

      t.timestamps
    end
    add_index :microposts, :user_id
    add_index :microposts, :group_id
    # to retrieve all the microposts associated with a given user id in reverse order of creation.
    add_index :microposts, [:user_id, :created_at]
  end
end
