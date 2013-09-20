class CreatePasswordRecoveries < ActiveRecord::Migration
  def change
    create_table :password_recoveries do |t|
      t.integer :user_id
      t.string :recovery_id
      t.string :status

      t.timestamps
    end
  end
end
