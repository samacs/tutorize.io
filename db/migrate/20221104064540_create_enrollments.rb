class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.string :slug, null: false, limit: 255
      t.datetime :scheduled_at, null: false
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :lecture, null: false, foreign_key: true

      t.timestamps
    end

    add_index :enrollments, :slug, unique: true
    add_index :enrollments, :scheduled_at, order: { scheduled_at: :desc }
  end
end
