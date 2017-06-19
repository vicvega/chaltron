class AddAdditionalLdapInfoToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :department, :string
  end
end
