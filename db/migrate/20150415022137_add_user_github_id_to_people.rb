class AddUserGithubIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :user_github_id, :integer
  end
end
