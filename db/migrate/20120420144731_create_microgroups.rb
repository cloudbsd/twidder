class CreateMicrogroups < ActiveRecord::Migration
  def change
    create_table :microgroups do |t|
      t.string :name
      t.text :description
      t.references :owner
      t.references :group

      t.timestamps
    end
    add_index :microgroups, :owner_id
    add_index :microgroups, :group_id
  end
end
