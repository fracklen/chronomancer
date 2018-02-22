class CreateApplicationSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :application_settings do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
