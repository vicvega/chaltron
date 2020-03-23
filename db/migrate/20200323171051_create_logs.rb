class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.string :message, limit: 1000
      t.string :severity
      t.string :category

      t.timestamps
    end
  end
end
