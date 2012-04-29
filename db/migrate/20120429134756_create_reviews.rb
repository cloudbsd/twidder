class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :content
      t.string :file
      t.integer :line
      t.references :user
      t.references :project

      t.timestamps
    end
    add_index :reviews, :user_id
    add_index :reviews, :project_id
    add_index :reviews, [:user_id, :project_id]
    add_index :reviews, [:project_id, :file, :line]
  end
end
