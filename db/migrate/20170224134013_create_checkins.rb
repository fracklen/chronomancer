class CreateCheckins < ActiveRecord::Migration[5.0]
  def change
    create_table :checkins do |t|
      t.references :canary, foreign_key: true
      t.string :user_agent
      t.string :ip
      t.text :message

      t.timestamps
    end
  end
end
