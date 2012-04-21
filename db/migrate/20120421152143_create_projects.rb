class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :path
      t.string :gravatar
      t.references :owner
      t.references :group

      t.timestamps
    end
    add_index :projects, :owner_id
    add_index :projects, :group_id
  end
end
