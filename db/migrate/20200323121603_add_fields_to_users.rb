class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :fullname, :string

    add_column :users, :provider, :string
    add_column :users, :extern_uid, :string

    add_column :users, :department, :string

    add_index :users, :username, unique: true
  end
end
