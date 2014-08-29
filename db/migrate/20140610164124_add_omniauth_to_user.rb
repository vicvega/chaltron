class AddOmniauthToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :extern_uid, :string
  end
end
