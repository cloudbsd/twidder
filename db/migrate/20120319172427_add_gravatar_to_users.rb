class AddGravatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gravatar, :string

  end
end
