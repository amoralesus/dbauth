class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :status
      t.string :linked_in_url
      t.timestamps
    end
  end
end
