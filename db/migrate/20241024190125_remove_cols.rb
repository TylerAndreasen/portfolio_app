class RemoveCols < ActiveRecord::Migration[7.1]
  def change
    remove_column :students, :email
    remove_column :students, :encrypted_password
    remove_column :students, :reset_password_token
    remove_column :students, :reset_password_sent_at
    remove_column :students, :remember_created_at
  end
end
