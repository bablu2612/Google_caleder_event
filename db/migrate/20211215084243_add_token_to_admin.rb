class AddTokenToAdmin < ActiveRecord::Migration[6.1]
 
  def change
    add_column :admins, :google_token, :string
    add_column :admins, :google_refresh_token, :string
 end
end
