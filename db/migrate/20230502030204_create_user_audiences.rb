class CreateUserAudiences < ActiveRecord::Migration[7.0]
  def change
    create_table :user_audiences, id: :uuid do |t|
      t.string :name, index: { unique: true }
      t.integer :subscriber_count, default: 0
      t.integer :subreddit_count, default: 0
      t.text :subreddit_names, array: true, default: []
      t.text :subreddit_icons, array: true, default: []
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
