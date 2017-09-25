class CreateAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :alerts do |t|
      t.references :canary, foreign_key: true
      t.string :kind

      t.timestamps
    end
  end
end
