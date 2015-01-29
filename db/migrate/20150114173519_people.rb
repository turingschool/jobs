class People < ActiveRecord::Migration
  def change
    add_column :people, :provider, :string
    add_column :people, :uid, :string
    add_column :people, :oauth_token, :string
    add_column :people, :oauth_secret, :string
  end
end
