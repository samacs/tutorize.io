class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, limit: 128
      t.string :last_name, null: false, limit: 128
      t.string :email, null: false, limit: 128
      t.string :password_digest, null: false, limit: 128
      t.string :confirmation_token, null: false, limit: 128
      t.string :password_reset_token, limit: 128
      t.datetime :confirmed_at
      t.datetime :password_reset_token_sent_at
      t.datetime :confirmation_token_sent_at
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet :current_sign_in_ip
      t.inet :last_sign_in_ip
      t.jsonb :preferences, null: false, default: {}
      t.integer :sign_in_count, null: false, default: 0
      t.boolean :terms_of_service, null: false, default: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :confirmation_token, unique: true
    add_index :users, :password_reset_token, unique: true
    add_index :users, :preferences, using: :gin
  end
end
