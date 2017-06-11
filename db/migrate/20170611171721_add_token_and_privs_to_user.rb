class AddTokenAndPrivsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :auth_token, :string
    add_column :users, :auth_issued, :datetime
    add_column :users, :privs, :json
  end
end
