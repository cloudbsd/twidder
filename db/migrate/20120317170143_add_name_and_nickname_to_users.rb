class AddNameAndNicknameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_index :users, :name, :unique => true

    add_column :users, :nickname, :string

  end
end
