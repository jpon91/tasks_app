class AddFacebooktokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebooktoken, :string
  end
end
