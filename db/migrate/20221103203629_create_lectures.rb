class CreateLectures < ActiveRecord::Migration[7.0]
  def change
    create_table :lectures do |t|
      t.string :slug, null: false, limit: 255
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.datetime :started_at
      t.datetime :ended_at
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end

    add_index :lectures, :slug, unique: true
    add_index :lectures, :starts_at, order: { starts_at: :desc }
    add_index :lectures, :ends_at, order: { starts_at: :desc }
  end
end
