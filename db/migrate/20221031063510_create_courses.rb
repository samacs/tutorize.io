class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name, null: false, limit: 128
      t.string :slug, null: false, limit: 255
      t.references :teacher, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :courses, :slug, unique: true
  end
end
