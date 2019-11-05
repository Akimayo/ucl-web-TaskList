class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.datetime :deadline_at, null: true
      t.string :title, null: false
      t.text :note, null: true
      t.boolean :is_done, null: false
      t.references :user, null: false, foreign_key: true
      t.references :category, null: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
