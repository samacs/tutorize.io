class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.string :name, null: false, limit: 128
      t.string :slug, null: false, limit: 255
      t.integer :minimum_students, null: false, default: 1
      t.integer :maximum_students, null: false, default: 3
      t.decimal :duration, precision: 8, scale: 2, null: false, default: 0
      t.references :course, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :lessons, :slug, unique: true
  end
end
