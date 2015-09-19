class CreateAppsUsers < ActiveRecord::Migration
  def change
    create_table :apps_users, id: false do |t|
      t.belongs_to :app, index: true
      t.belongs_to :user, index: true
    end
  end
end
