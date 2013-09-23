class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.integer :person_id
      t.integer :company_id
      t.date :start_date
      t.date :end_date
      t.string :work_phone
      t.string :work_email
      t.string :status 

      t.timestamps
    end
  end
end
