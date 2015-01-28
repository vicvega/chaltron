class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :message, limit: 1000
      t.string :severity
      t.string :category

      t.timestamps null: false
    end
  end
end
