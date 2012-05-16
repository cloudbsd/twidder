class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :point
      t.references :user
      t.references :review

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :review_id
  end
end
