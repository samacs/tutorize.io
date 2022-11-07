class CreateAvailabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :availabilities do |t|
      t.datetime :date
      t.integer :weekday
      t.decimal :from, null: false, default: 0.0, precision: 8, scale: 2
      t.decimal :to, null: false, default: 0.0, precision: 8, scale: 2
      t.boolean :available, null: false, default: true
      t.references :teacher, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :availabilities, :date
    add_index :availabilities, :weekday
    add_index :availabilities, :from
    add_index :availabilities, :to
  end
end
