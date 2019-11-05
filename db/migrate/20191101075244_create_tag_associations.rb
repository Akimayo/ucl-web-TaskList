class CreateTagAssociations < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_associations do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
