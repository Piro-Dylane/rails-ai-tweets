class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.text :long
      t.text :shortened

      t.timestamps
    end
  end
end
