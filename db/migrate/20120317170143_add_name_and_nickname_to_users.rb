class AddNameAndNicknameToUsers < ActiveRecord::Migration
# def change
#   add_column :users, :name, :string
#   add_index :users, :name, :unique => true

#   add_column :users, :nickname, :string

# end

  def change
    change_table :users do |t|
      t.string :name,              :null => false, :default => ""
      t.string :nickname,          :null => false, :default => ""
    end
    add_index :users, :name,       :unique => true
  end
end
