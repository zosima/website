class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.timestamps
      t.string :google_id
    end
  end
end
