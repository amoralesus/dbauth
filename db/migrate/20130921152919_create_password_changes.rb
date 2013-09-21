class CreatePasswordChanges < ActiveRecord::Migration
  def change
    create_table :password_changes do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
