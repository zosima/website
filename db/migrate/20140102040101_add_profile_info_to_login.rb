class AddProfileInfoToLogin < ActiveRecord::Migration
  def change
    add_column :logins, :image_url, :string
    add_column :logins, :display_name, :string
    add_column :logins, :url, :string
  end
end
