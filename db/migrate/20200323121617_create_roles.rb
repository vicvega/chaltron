class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.timestamps
    end

    create_table :role_assignments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.references :assigned_by, references: :users, foreign_key: {to_table: :users}
      t.timestamps
    end

  end
end
